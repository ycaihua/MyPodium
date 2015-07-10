//
//  MPFriendsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPFriendsModel.h"
#import "MPGlobalModel.h"

#import "MPUserCell.h"
#import "MPFriendsView.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPFriendsViewController.h"
#import "MPMakeTeamViewController.h"
#import "MPUserProfileViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPFriendsViewController ()

@end

@implementation MPFriendsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPFriendsView* view = [[MPFriendsView alloc] init];
        self.view = view;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeTableSections];
        UITableView* table = view.friendsTable;
        [table registerClass:[MPUserCell class]
      forCellReuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPFriendsViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [self refreshData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPFriendsViewController incomingHeader]
                            withDataBlock:^(){
                                NSArray* incoming = [MPFriendsModel incomingPendingRequestsForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPFriendsView* view = (MPFriendsView*) self.view;
                                    return [MPGlobalModel userList:incoming searchForString:view.filterSearch.searchField.text];
                                }
                                else return incoming;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPFriendsViewController friendsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell showLeftButton];
                                [cell.leftButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(acceptIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(incomingProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(denyIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPUserCell*)cell updateForUser:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPFriendsViewController outgoingHeader]
                            withDataBlock:^(){
                                NSArray* outgoing = [MPFriendsModel outgoingPendingRequestsForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPFriendsView* view = (MPFriendsView*) self.view;
                                    return [MPGlobalModel userList:outgoing searchForString:view.filterSearch.searchField.text];
                                }
                                else return outgoing;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPFriendsViewController friendsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell hideLeftButton];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.centerButton addTarget:self action:@selector(outgoingProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(cancelOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPUserCell*)cell updateForUser:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPFriendsViewController friendsHeader]
                            withDataBlock:^(){
                                NSArray* friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPFriendsView* view = (MPFriendsView*) self.view;
                                    return [MPGlobalModel userList:friends searchForString:view.filterSearch.searchField.text];
                                }
                                else return friends;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPFriendsViewController friendsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell hideLeftButton];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.centerButton addTarget:self action:@selector(friendProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPUserCell*)cell updateForUser:object];
                            }]
                            ];
}

- (void) loadOnDismiss: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    [view startLoading];
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ReloadQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* section in self.tableSections) {
            [section reloadData];
        }
        [self updateHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.friendsTable reloadData];
            [view finishLoading];
        });
    });
}

- (void) refreshData {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("RefreshQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* section in self.tableSections) {
            [section reloadData];
        }
        [self updateHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            MPFriendsView* view = (MPFriendsView*) self.view;
            [view.friendsTable reloadData];
        });
    });
}

- (void) updateHeaders {
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPFriendsViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

#pragma mark cell targets

- (void) performModelUpdate: (BOOL (^)(void)) methodAction
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
      withConfirmationAlert: (BOOL) showAlert
    withConfirmationMessage: (NSString*) alertMessage {
    MPFriendsView* view = (MPFriendsView*) self.view;
    
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
                        view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                        [self refreshData];
                        [view.friendsTable reloadData];
                    }
                    else {
                        view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                    }
                });
            });
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
            [view.menu.subtitleLabel displayMessage:[MPFriendsView defaultSubtitle] revertAfter:false withColor:[UIColor whiteColor]];
            
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
                    view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage: successMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [self refreshData];
                    [view.friendsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                }
            });
        });
    }
}

- (void) acceptIncomingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController incomingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel acceptRequestFromUser:other toUser:[PFUser currentUser] canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You accepted %@'s friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:false
     withConfirmationMessage:@""];
}

- (void) incomingProfileButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController incomingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) denyIncomingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController incomingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController outgoingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) cancelOutgoingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController outgoingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeRequestFromUser:[PFUser currentUser] toUser:other canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your friend request to %@.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to cancel your friend request to %@?", other.username]];
}

- (void) friendProfileButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController friendsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeFriendButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPFriendsViewController friendsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeFriendRelationWithFirstUser:other secondUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You successfully removed %@ as a friend.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to remove %@ as a friend?", other.username]];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPFriendsViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPFriendsViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController blankReuseIdentifier]];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }
    else {
        NSString* sectionHeader = self.sectionHeaderNames[indexPath.section];
        MPTableSectionUtility* section = [self tableSectionWithHeader: sectionHeader];
        UITableViewCell* cell = section.cellCreationBlock(tableView, indexPath);
        id object = section.dataObjects[indexPath.row];
        section.cellUpdateBlock(cell, object);
        return cell;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:[MPFriendsViewController noneFoundHeader]])
        return 1;
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.sectionHeaderNames[section]];
    return  sectionUtility.dataObjects.count;
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

- (MPTableSectionUtility*) tableSectionWithHeader: (NSString*) header {
    for(MPTableSectionUtility* section in self.tableSections) {
        if([section.headerTitle isEqualToString: header])
            return section;
    }
    return nil;
}

#pragma mark button actions


#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    [view.filterSearch.searchField resignFirstResponder];
    NSString* filterString = view.filterSearch.searchField.text;
    self.isFiltered = !(filterString.length == 0);
    [self refreshData];
}

#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self textFieldShouldClear: textField];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self filterSearchButtonPressed:nil];
    return YES;
}

#pragma mark constants


+ (NSString*) incomingHeader { return @"INCOMING FRIEND REQUESTS"; }
+ (NSString*) outgoingHeader { return @"OUTGOING FRIEND REQUESTS"; }
+ (NSString*) friendsHeader { return @"FRIENDS"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) friendsReuseIdentifier { return @"FriendsCell"; }
+ (NSString*) blankReuseIdentifier { return @"BlankCell"; }
@end