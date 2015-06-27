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
    //Blank cell
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
             [MPSearchViewController friendsHeader]]) {
        MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
        }
        
        cell.indexPath = indexPath;
        PFUser* user = self.matchingFriends[indexPath.row];
        [cell updateForUser: user];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(friendProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController incomingRequestsHeader]]) {
        MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
        }
        
        cell.indexPath = indexPath;
        PFUser* user = self.matchingIncomingRequests[indexPath.row];
        [cell updateForUser: user];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
        //Set images
        [cell.leftButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(acceptIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(removeIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController outgoingRequestsHeader]]) {
        
        MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
        }
        
        cell.indexPath = indexPath;
        PFUser* user = user = self.matchingOutgoingRequests[indexPath.row];
        [cell updateForUser: user];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(outgoingProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(removeOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:[MPSearchViewController usersHeader]]) {
        MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
        }
        
        cell.indexPath = indexPath;
        PFUser* user = self.matchingUsers[indexPath.row];
        [cell updateForUser: user];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];

        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(sendUserRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController ownedTeamsHeader]]) {
        MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
        }
        cell.indexPath = indexPath;
        PFObject* team = self.matchingOwnedTeams[indexPath.row];
        [cell updateForTeam: team];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
        
        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        return cell;
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPSearchViewController teamsAsMemberHeader]]) {
        MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
        }
        cell.indexPath = indexPath;
        PFObject* team = self.matchingTeamsAsMember[indexPath.row];
        [cell updateForTeam: team];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
        
        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        return cell;
    }
    else {
        MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                            [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
        }
        cell.indexPath = indexPath;
        PFObject* team = self.matchingVisibleTeams[indexPath.row];
        [cell updateForTeam: team];
        //Remove any existing actions
        [cell.leftButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
        [cell.rightButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
        
        //Set images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
        //Add targets
        return cell;
        
    }
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
    }
}

- (void) friendProfileButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingFriends[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeFriendButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
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

- (void) acceptIncomingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingIncomingRequests[indexPath.row];
    
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel acceptRequestFromUser:other toUser:[PFUser currentUser] canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You accepted %@'s friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:false
     withConfirmationMessage:@""];
}

- (void) removeIncomingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingIncomingRequests[indexPath.row];
    
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeRequestFromUser:other toUser:[PFUser currentUser] canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You denied %@'s friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to deny the friend request from %@?", other.username]];
}

- (void) outgoingProfileButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingOutgoingRequests[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeOutgoingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingOutgoingRequests[indexPath.row];
    
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeRequestFromUser:[PFUser currentUser] toUser:other canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your friend request to %@.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to cancel your friend request to %@?", other.username]];
}

- (void) userProfileButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingUsers[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) sendUserRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    PFUser* other = self.matchingUsers[indexPath.row];
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
             [MPSearchViewController incomingRequestsHeader]]) {
        return self.matchingIncomingRequests.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController outgoingRequestsHeader]]) {
        return self.matchingOutgoingRequests.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController ownedTeamsHeader]]) {
        return self.matchingOwnedTeams.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController teamsAsMemberHeader]]) {
        return self.matchingTeamsAsMember.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPSearchViewController visibleTeamsHeader]]) {
        return self.matchingVisibleTeams.count;
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
    if(self.matchingFriends.count + self.matchingIncomingRequests.count + self.matchingOutgoingRequests.count + self.matchingOwnedTeams.count + self.matchingTeamsAsMember.count + self.matchingUsers.count + self.matchingVisibleTeams.count == 0) {
        [self.sectionHeaderNames addObject:[MPSearchViewController noneFoundHeader]];
        return;
    }
    if(self.matchingFriends.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController friendsHeader]];
    if(self.matchingIncomingRequests.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController incomingRequestsHeader]];
    if(self.matchingOutgoingRequests.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController outgoingRequestsHeader]];
    if(self.matchingUsers.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController usersHeader]];
    if(self.matchingOwnedTeams.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController ownedTeamsHeader]];
    if(self.matchingTeamsAsMember.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController teamsAsMemberHeader]];
    if(self.matchingVisibleTeams.count > 0)
        [self.sectionHeaderNames addObject:[MPSearchViewController visibleTeamsHeader]];
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
        self.matchingIncomingRequests = @[];
        self.matchingOutgoingRequests = @[];
        self.matchingOwnedTeams = @[];
        self.matchingTeamsAsMember = @[];
        self.matchingVisibleTeams = @[];
        [self updateUnfilteredHeaders];
        MPSearchView* view = (MPSearchView*) self.view;
        [view.searchTable reloadData];
        return;
    }
    
    MPSearchView* view = (MPSearchView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    [view.searchView.searchField resignFirstResponder];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("SearchQueue", 0);
    dispatch_async(backgroundQueue, ^{
        
        self.matchingFriends = [MPFriendsModel friendsForUser:[PFUser currentUser] containingString:string];
        
        NSArray* incoming = [MPFriendsModel incomingPendingRequestsForUser: [PFUser currentUser]];
        self.matchingIncomingRequests = [MPGlobalModel userList:incoming searchForString:string];
        
        NSArray* outgoing = [MPFriendsModel outgoingPendingRequestsForUser: [PFUser currentUser]];
        self.matchingOutgoingRequests = [MPGlobalModel userList:outgoing searchForString:string];
        
        NSArray* ownedTeams = [MPTeamsModel teamsCreatedByUser:[PFUser currentUser]];
        self.matchingOwnedTeams = [MPGlobalModel teamList:ownedTeams searchForString:string];
        
        NSArray* memberTeams = [MPTeamsModel teamsContainingUser:[PFUser currentUser]];
        self.matchingTeamsAsMember = [MPGlobalModel teamList:memberTeams searchForString:string];
        
        NSArray* visibleTeams = [MPTeamsModel teamsVisibleToUser:[PFUser currentUser]];
        self.matchingVisibleTeams = [MPGlobalModel teamList:visibleTeams searchForString:string];
        
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
+ (NSString*) incomingRequestsHeader { return @"INCOMING FRIEND REQUESTS"; }
+ (NSString*) outgoingRequestsHeader { return @"OUTGOING FRIEND REQUESTS"; }
+ (NSString*) usersHeader { return @"OTHER USERS"; }
+ (NSString*) ownedTeamsHeader { return @"OWNED TEAMS"; }
+ (NSString*) teamsAsMemberHeader { return @"TEAMS I'M ON"; }
+ (NSString*) visibleTeamsHeader { return @"OTHER VISIBLE TEAMS"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }
+ (NSString*) userReuseIdentifier { return @"userSearchIdentifier"; }
+ (NSString*) teamReuseIdentifier { return @"teamSearchIdentifier"; }
+ (NSString*) blankReuseIdentifier { return @"blankIdentifier"; }

@end
