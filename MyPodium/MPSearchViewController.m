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
#import "MPTableSectionUtility.h"

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
#import "MPLabel.h"

#import "MPSearchViewController.h"
#import "MPUserProfileViewController.h"
#import "MPMakeTeamViewController.h"

@interface MPSearchViewController ()

@end

@implementation MPSearchViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSearchView* view = [[MPSearchView alloc] init];
        self.view = view;
        [self makeTableSections];
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

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController friendsHeader]
                            withDataBlock:^() {
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPFriendsModel friendsForUser:[PFUser currentUser] containingString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath) {
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
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
                            withCellUpdateBlock:^(UITableViewCell* cell, id object) {
                                [(MPUserCell*)cell updateForUser:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController incomingRequestsHeader]
                            withDataBlock:^(){
                                NSArray* incoming = [MPFriendsModel incomingPendingRequestsForUser: [PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userList:incoming searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
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
                                [cell.rightButton addTarget:self action:@selector(removeIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPUserCell*)cell updateForUser:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController outgoingRequestsHeader]
                            withDataBlock:^(){
                                NSArray* outgoing = [MPFriendsModel outgoingPendingRequestsForUser: [PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userList:outgoing searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
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
                                [cell.rightButton addTarget:self action:@selector(removeOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPUserCell*)cell updateForUser:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController usersHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userSearchContainingString:view.searchView.searchField.text forUser:[PFUser currentUser]];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
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
                                [cell.rightButton setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.centerButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(sendUserRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPUserCell*)cell updateForUser:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController ownedTeamsHeader]
                            withDataBlock:^(){
                                NSArray* ownedTeams = [MPTeamsModel teamsCreatedByUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel teamList:ownedTeams searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
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
                                [cell.leftButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(leaveOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(ownedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(deleteOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController teamsAsMemberHeader]
                            withDataBlock:^(){
                                NSArray* memberTeams = [MPTeamsModel teamsContainingUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel teamList:memberTeams searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
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
                                [cell.centerButton addTarget:self action:@selector(memberTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(leaveTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController teamsInvitingHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                NSArray* invites = [MPTeamsModel teamsInvitingUser:[PFUser currentUser]];
                                return [MPGlobalModel teamList:invites searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
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
                                [cell.rightButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(acceptTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(teamInviteProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(denyTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController teamsRequestedToJoinHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                NSArray* joinRequests = [MPTeamsModel teamsRequestedByUser:[PFUser currentUser]];
                                return [MPGlobalModel teamList:joinRequests searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
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
                                [cell.centerButton addTarget:self action:@selector(requestedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(cancelTeamRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam: object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController visibleTeamsHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                NSArray* visibleTeams = [MPTeamsModel teamsVisibleToUser:[PFUser currentUser]];
                                return [MPGlobalModel teamList:visibleTeams searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
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
                                [cell.rightButton setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.centerButton addTarget:self action:@selector(visibleTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(requestToJoinTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }]];
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
    else {
        NSString* sectionHeader = self.sectionHeaderNames[indexPath.section];
        MPTableSectionUtility* section = [self tableSectionWithHeader: sectionHeader];
        UITableViewCell* cell = section.cellCreationBlock(tableView, indexPath);
        id object = section.dataObjects[indexPath.row];
        section.cellUpdateBlock(cell, object);
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
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
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
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController friendsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeFriendButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController friendsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController incomingRequestsHeader]];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController incomingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeIncomingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController incomingRequestsHeader]];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController outgoingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeOutgoingButtonPressed: (id) sender {
    MPUserCell* cell = (MPUserCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController outgoingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController usersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) sendUserRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController usersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel sendRequestFromUser:[PFUser currentUser] toUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You sent %@ a friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to send %@ a friend request?", other.username]];
}

- (void) ownedTeamProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) leaveOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You left your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to leave your team, %@? A new owner will be chosen.", other[@"teamName"]]];
}

- (void) deleteOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel deleteTeam: other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to delete your team, %@? This cannot be undone.", other[@"teamName"]]];
}

- (void) memberTeamProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) leaveTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsAsMemberHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to leave your team, %@? If you are the owner, a new owner will be assigned.", other[@"teamName"]]];
}

- (void) acceptTeamInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsInvitingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel acceptInviteFromTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You joined the team %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to accept the invitation from %@?", other[@"teamName"]]];
}

- (void) teamInviteProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) denyTeamInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsInvitingHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyInviteFromTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You denied the team invite from %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to deny the invitation from %@?", other[@"teamName"]]];
}

- (void) requestedTeamProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) cancelTeamRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsRequestedToJoinHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyTeamJoinRequest:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your join request for %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to cancel your join request for the team %@?", other[@"teamName"]]];
}

- (void) visibleTeamProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) requestToJoinTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController visibleTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel requestToJoinTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You requested to join %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to request to join the team, %@?", other[@"teamName"]]];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:[MPSearchViewController noneFoundHeader]])
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
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPSearchViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

#pragma mark button actions

- (void) searchButtonPressed: (id) sender {
    MPSearchView* view = (MPSearchView*) self.view;
    [self filterDataWithString:view.searchView.searchField.text];
}

- (void) filterDataWithString: (NSString*) string {
    if(string.length == 0)
        return;
    
    MPSearchView* view = (MPSearchView*) self.view;
    [view startLoading];
    [view.searchView.searchField resignFirstResponder];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("SearchQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* sectionUtility in self.tableSections) {
            [sectionUtility reloadData];
        }
        [self updateUnfilteredHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.searchTable reloadData];
            [view finishLoading];
        });
    });
}

- (MPTableSectionUtility*) tableSectionWithHeader: (NSString*) header {
    for(MPTableSectionUtility* section in self.tableSections) {
        if([section.headerTitle isEqualToString: header])
            return section;
    }
    return nil;
}

#pragma mark class methods

+ (NSString*) friendsHeader { return @"FRIENDS"; }
+ (NSString*) incomingRequestsHeader { return @"INCOMING FRIEND REQUESTS"; }
+ (NSString*) outgoingRequestsHeader { return @"OUTGOING FRIEND REQUESTS"; }
+ (NSString*) usersHeader { return @"OTHER USERS"; }
+ (NSString*) ownedTeamsHeader { return @"OWNED TEAMS"; }
+ (NSString*) teamsAsMemberHeader { return @"TEAMS I'M ON"; }
+ (NSString*) teamsInvitingHeader { return @"TEAMS INVITING ME"; }
+ (NSString*) teamsRequestedToJoinHeader { return @"TEAMS I REQUESTED TO JOIN"; }
+ (NSString*) visibleTeamsHeader { return @"OTHER VISIBLE TEAMS"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }
+ (NSString*) userReuseIdentifier { return @"userSearchIdentifier"; }
+ (NSString*) teamReuseIdentifier { return @"teamSearchIdentifier"; }
+ (NSString*) blankReuseIdentifier { return @"blankIdentifier"; }

@end
