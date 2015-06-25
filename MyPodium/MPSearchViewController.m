//
//  MPSearchViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"
#import "MPGlobalModel.h"

#import "MPSearchView.h"
#import "MPUserCell.h"
#import "MPTeamCell.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPSearchViewController.h"
#import "MPUserProfileViewController.h"

@interface MPSearchViewController ()

@end

@implementation MPSearchViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSearchView* view = [[MPSearchView alloc] init];
        self.view = view;
        [self updateUnfilteredHeaders];
        UITableView* table = view.searchTable;
        [table registerClass:[MPUserCell class]
      forCellReuseIdentifier:[MPSearchViewController userReuseIdentifier]];
        [table registerClass:[MPTeamCell class]
      forCellReuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPSearchViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [table reloadData];
        //searchView init
        [view.searchView.searchButton addTarget:self
                                           action:@selector(searchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.searchView.searchField.delegate = self;
    }
    return self;
}

- (void) loadOnDismiss: (id) sender {
    [self searchButtonPressed: self];
}

#pragma mark table view data/delegate
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPSearchViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                [MPSearchViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController blankReuseIdentifier]];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController teamsHeader]]) {
        MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
        }
        
        PFObject* team = self.matchingTeams[indexPath.row];
        [cell updateForTeam: team];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    
    PFUser* user;
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController friendsHeader]]) {
        user = self.matchingFriends[indexPath.row];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController pendingRequestsHeader]]) {
        user = self.matchingPendingRequests[indexPath.row];
    }
    else {
        user = self.matchingUsers[indexPath.row];
    }
    [cell updateForUser: user];
    
    
    //Remove any existing actions
    [cell.leftButton removeTarget:nil
                           action:NULL
                 forControlEvents:UIControlEventAllEvents];
    [cell.rightButton removeTarget:nil
                            action:NULL
                  forControlEvents:UIControlEventAllEvents];
    
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPSearchViewController friendsHeader]]) {
        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(friendProfilePressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController pendingRequestsHeader]]) {
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:[MPSearchViewController usersHeader]]) {
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
        
    }
    else {//if([self.sectionHeaderNames[indexPath.section] isEqualToString:[MPSearchViewController teamsHeader]]) {
        
    }
    
    return cell;
}

- (void) performModelUpdate: (BOOL (^)(void)) methodAction
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
      withConfirmationAlert: (BOOL) showAlert
    withConfirmationMessage: (NSString*) alertMessage {
    MPSearchView* view = (MPSearchView*) self.view;
    
    if(showAlert) {
        UIAlertController* confirmationAlert =
        [UIAlertController alertControllerWithTitle:@"Confirmation"
                                            message:alertMessage
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
            //Background thread
            dispatch_queue_t backgroundQueue = dispatch_queue_create("ActionQueue", 0);
            dispatch_async(backgroundQueue, ^{
                BOOL success = methodAction();
                dispatch_async(dispatch_get_main_queue(), ^{
                    //Update UI, based on success
                    if(success) {
                        view.menu.subtitleLabel.persistentText = [MPSearchView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                        [self searchButtonPressed: self];
                        [view.searchTable reloadData];
                    }
                    else {
                        view.menu.subtitleLabel.persistentText = [MPSearchView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage                                                 revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                        [view.searchTable reloadData];
                    }
                });
            });
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
            [view.menu.subtitleLabel displayMessage:[MPSearchView defaultSubtitle] revertAfter:false withColor:[UIColor whiteColor]];
            
        }];
        [confirmationAlert addAction: confirmAction];
        [confirmationAlert addAction: cancelAction];
        [self presentViewController: confirmationAlert animated: true completion:nil];
    }
    else {
        
    }
}

- (void) friendProfilePressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingFriends[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeFriendButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingFriends[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeFriendRelationWithFirstUser:other secondUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You successfully removed %@ as a friend.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to remove %@ as a friend?", other.username]];
    
}

- (void) addFriendButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingFriends[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel sendRequestFromUser:[PFUser currentUser] toUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You sent %@ a friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to send %@ a friend request?", other.username]];
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:
        [MPSearchViewController friendsHeader]]) {
        return self.matchingFriends.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController usersHeader]]) {
        return self.matchingUsers.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController pendingRequestsHeader]]) {
        return self.matchingPendingRequests.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController teamsHeader]]) {
        return self.matchingTeams.count;
    }
    else {
        return 1;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPUserCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:self.sectionHeaderNames[section]];
}

#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    [self searchButtonPressed: nil];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchButtonPressed: nil];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self textFieldShouldClear: textField];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self searchButtonPressed:nil];
    return YES;
}

#pragma mark table headers

- (void) updateUnfilteredHeaders {
    self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
    if(self.matchingFriends.count == 0 &&
       self.matchingPendingRequests.count == 0 &&
       self.matchingUsers.count == 0 &&
       self.matchingTeams.count == 0) {
        [self.sectionHeaderNames addObject:[MPSearchViewController noneFoundHeader]];
        return;
    }
    if(self.matchingFriends.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController friendsHeader]];
    if(self.matchingPendingRequests.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController pendingRequestsHeader]];
    if(self.matchingUsers.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController usersHeader]];
    if(self.matchingTeams.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController teamsHeader]];
}

#pragma mark button actions

- (void) searchButtonPressed: (id) sender {
    MPSearchView* view = (MPSearchView*) self.view;
    [self filterDataWithString:view.searchView.searchField.text];
}

- (void) filterDataWithString: (NSString*) string {
    if(string.length == 0) {
        self.matchingFriends = @[];
        self.matchingUsers = @[];
        self.matchingPendingRequests = @[];
        self.matchingTeams = @[];
        [self updateUnfilteredHeaders];
        MPSearchView* view = (MPSearchView*) self.view;
        [view.searchTable reloadData];
        return;
    }
    
    MPSearchView* view = (MPSearchView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Searching..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    [view.searchView.searchField resignFirstResponder];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
    dispatch_async(backgroundQueue, ^{
        
        self.matchingFriends = [MPFriendsModel friendsForUser:[PFUser currentUser] containingString:string];
        NSMutableArray* pendingRequests = [MPFriendsModel incomingPendingRequestsForUser: [PFUser currentUser]].mutableCopy;
        [pendingRequests addObjectsFromArray:[MPFriendsModel outgoingPendingRequestsForUser: [PFUser currentUser]]];
        self.matchingPendingRequests = [MPGlobalModel userList:pendingRequests searchForString:string];
        NSArray* teams = [MPTeamsModel teamsVisibleToUser:[PFUser currentUser]];
        self.matchingTeams = [MPGlobalModel teamList:teams searchForString:string];
        self.matchingUsers = [MPGlobalModel userSearchContainingString:string forUser:[PFUser currentUser]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUnfilteredHeaders];
            [view.searchTable reloadData];
            [view.menu.subtitleLabel displayMessage:[MPSearchView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
        });
    });
}

#pragma mark class methods

+ (NSString*) friendsHeader { return @"FRIENDS"; }
+ (NSString*) pendingRequestsHeader { return @"PENDING FRIEND REQUESTS"; }
+ (NSString*) usersHeader { return @"OTHER USERS"; }
+ (NSString*) teamsHeader { return @"TEAMS"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }
+ (NSString*) userReuseIdentifier { return @"userSearchIdentifier"; }
+ (NSString*) teamReuseIdentifier { return @"teamSearchIdentifier"; }
+ (NSString*) blankReuseIdentifier { return @"blankIdentifier"; }

@end
