//
//  MPTeamRosterViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTableSectionUtility.h"
#import "MPControllerManager.h"
#import "UIColor+MPColor.h"

#import "MPTeamRosterView.h"
#import "MPTableViewCell.h"
#import "MPTableHeader.h"
#import "MPLabel.h"
#import "MPMenu.h"
#import "MPBottomEdgeButton.h"

#import "MPUserProfileViewController.h"
#import "MPTeamRosterViewController.h"

@interface MPTeamRosterViewController ()

@end

@implementation MPTeamRosterViewController

- (id) initWithTeam:(PFObject *)team {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] initWithTitleText:@"MY PODIUM" subtitleText:@"Loading..."];
        dispatch_async(dispatch_queue_create("UserInfoQueue", 0), ^{
            MPTeamStatus status = [MPTeamsModel teamStatusForUser:[PFUser currentUser] forTeam:team];
            self.status = status;
            dispatch_async(dispatch_get_main_queue(), ^{
                MPTeamRosterView* view = [[MPTeamRosterView alloc] initWithTeam:team andTeamStatus:status];
                self.view = view;
                self.team = team;
                self.delegate = self;
                [view.rosterTable registerClass:[MPTableViewCell class] forCellReuseIdentifier:[MPTeamRosterViewController usersReuseIdentifier]];
                view.rosterTable.delegate = self;
                view.rosterTable.dataSource = self;
                [self makeTableSections];
                [self addMenuActions];
                [self makeBottomButtonActions];
                [self reloadData];
            });
        });
    }
    return self;
}

#pragma mark MPDataLoader

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPTeamRosterViewController* rosterVC = (MPTeamRosterViewController*)controller;
    for(MPTableSectionUtility* section in rosterVC.tableSections) {
        [section reloadData];
    }
    [rosterVC updateHeaders];
    MPTeamRosterView* view = (MPTeamRosterView*) self.view;
    MPTeamStatus newStatus = [MPTeamsModel teamStatusForUser:[PFUser currentUser] forTeam:self.team];
    self.status = newStatus;
    view.teamStatus = newStatus;
    dispatch_async(dispatch_get_main_queue(), ^{
        [view refreshControlsForTeamUpdate];
        [self makeBottomButtonActions];
    });
}


- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPTeamRosterViewController* rosterVC = (MPTeamRosterViewController*)controller;
    MPTeamRosterView* view = (MPTeamRosterView*)rosterVC.view;
    return view.rosterTable;
}

#pragma mark UITableView

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamRosterViewController ownerHeader]
                            withDataBlock:^(){
                                return @[self.team[@"owner"]];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                         [MPTeamRosterViewController usersReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamRosterViewController usersReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:1];
                                [cell clearButtonActions];
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"]]];
                                
                                //Add targets
                                [cell.buttons[0] addTarget:self action:@selector(ownerProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*) cell withUserObject:object];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                                initWithHeaderTitle:[MPTeamRosterViewController membersHeader]
                                withDataBlock:^(){
                                    NSMutableArray* members = [MPTeamsModel membersForTeam: self.team].mutableCopy;
                                    if(self.status != MPTeamStatusOwner) return members;
                                    
                                    //if current user is the owner, don't display him as a member too
                                    for(int i = 0; i < members.count; i++) {
                                        PFUser* current = members[i];
                                        if([current.username isEqualToString: [PFUser currentUser].username] &&
                                           self.status == MPTeamStatusOwner) {
                                            [members removeObject: current];
                                            return members;
                                        }
                                    }
                                    return members;
                                }
                                withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                             [MPTeamRosterViewController usersReuseIdentifier] forIndexPath:indexPath];
                                    if(!cell) {
                                        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamRosterViewController usersReuseIdentifier]];
                                    }
                                    
                                    cell.indexPath = indexPath;
                                    if(self.status == MPTeamStatusOwner) {
                                            [cell setNumberOfButtons:3];
                                            [cell clearButtonActions];
                                            [cell setButtonImageStrings:@[@[@"up", @"green"],
                                                                          @[@"info", @"yellow"],
                                                                          @[@"x", @"red"]]];
                                            
                                            [cell.buttons[2] addTarget:self
                                                                action:@selector(promoteMemberButtonPressed:)
                                                      forControlEvents:UIControlEventTouchUpInside];
                                            [cell.buttons[1] addTarget:self
                                                                action:@selector(memberProfileButtonPressed:)
                                                      forControlEvents:UIControlEventTouchUpInside];
                                            [cell.buttons[0] addTarget:self
                                                                action:@selector(removeMemberButtonPressed:)
                                                      forControlEvents:UIControlEventTouchUpInside];
                                    }
                                    else {
                                            [cell setNumberOfButtons:1];
                                            [cell clearButtonActions];
                                            [cell setButtonImageStrings:@[@[@"info", @"yellow"]]];
                                            
                                            [cell.buttons[0] addTarget:self
                                                                action:@selector(ownerProfileButtonPressed:)
                                                      forControlEvents:UIControlEventTouchUpInside];
                                    }
                                    
                                    return cell;
                                }
                                withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                    [MPTableSectionUtility updateCell:(MPTableViewCell*) cell withUserObject:object];
                                }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamRosterViewController invitedHeader]
                            withDataBlock:^(){
                                return [MPTeamsModel invitedUsersForTeam: self.team];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                         [MPTeamRosterViewController usersReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamRosterViewController usersReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                if(self.status == MPTeamStatusOwner) {
                                    [cell setNumberOfButtons:2];
                                    [cell clearButtonActions];
                                    [cell setButtonImageStrings:@[@[@"info", @"yellow"],
                                                                  @[@"x", @"red"]]];
                                    
                                    [cell.buttons[1] addTarget:self
                                                        action:@selector(invitedProfileButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                    [cell.buttons[0] addTarget:self
                                                        action:@selector(cancelInviteButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                }
                                else {
                                    [cell setNumberOfButtons:1];
                                    [cell clearButtonActions];
                                    [cell setButtonImageStrings:@[@[@"info", @"yellow"]]];
                                    
                                    [cell.buttons[0] addTarget:self
                                                        action:@selector(invitedProfileButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                }
                                
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*) cell withUserObject:object];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamRosterViewController requestedHeader]
                            withDataBlock:^(){
                                return [MPTeamsModel requestingUsersForTeam: self.team];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                         [MPTeamRosterViewController usersReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamRosterViewController usersReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                if(self.status == MPTeamStatusOwner) {
                                    [cell setNumberOfButtons:3];
                                    [cell clearButtonActions];
                                    [cell setButtonImageStrings:@[@[@"check", @"green"],
                                                                  @[@"info", @"yellow"],
                                                                  @[@"x", @"red"]]];
                                    
                                    [cell.buttons[2] addTarget:self
                                                        action:@selector(acceptRequestButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                    [cell.buttons[1] addTarget:self
                                                        action:@selector(requestedProfileButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                    [cell.buttons[0] addTarget:self
                                                        action:@selector(denyRequestButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                }
                                else {
                                    [cell setNumberOfButtons:1];
                                    [cell clearButtonActions];
                                    [cell setButtonImageStrings:@[@[@"info", @"yellow"]]];
                                    
                                    [cell.buttons[0] addTarget:self
                                                        action:@selector(requestedProfileButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                                }
                                
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*) cell withUserObject:object];
                            }],

                           ];
}

- (void) updateHeaders {
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    self.tableHeaders = headerNames;
}

#pragma mark UITableView delegate/data source

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.tableHeaders[section]];
    return  sectionUtility.dataObjects.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:self.tableHeaders[section]];
}

- (MPTableSectionUtility*) tableSectionWithHeader: (NSString*) header {
    for(MPTableSectionUtility* section in self.tableSections) {
        if([section.headerTitle isEqualToString: header])
            return section;
    }
    return nil;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* sectionHeader = self.tableHeaders[indexPath.section];
    MPTableSectionUtility* section = [self tableSectionWithHeader: sectionHeader];
    UITableViewCell* cell = section.cellCreationBlock(tableView, indexPath);
    id object = section.dataObjects[indexPath.row];
    section.cellUpdateBlock(cell, object);
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableHeaders.count;
}

#pragma mark button actions

- (void) performModelUpdate: (BOOL (^)(void)) methodAction
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
      withConfirmationAlert: (BOOL) showAlert
    withConfirmationMessage: (NSString*) alertMessage {
    MPTeamRosterView* view = (MPTeamRosterView*) self.view;
    [view startLoading];
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
                        [self reloadDataWithCompletionBlock:^{
                            view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                            view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                            [view.menu.subtitleLabel displayMessage: successMessage
                                                        revertAfter:YES
                                                          withColor:[UIColor MPGreenColor]];
                            
                        }];
                    }
                    else {
                        [self reloadDataWithCompletionBlock:^{
                            view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                            view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                            [view.menu.subtitleLabel displayMessage:errorMessage
                                                        revertAfter:YES
                                                          withColor:[UIColor MPRedColor]];
                        }];
                    }
                });
            });
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
            [view.menu.subtitleLabel displayMessage:[MPTeamRosterView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
            
        }];
        [confirmationAlert addAction: confirmAction];
        [confirmationAlert addAction: cancelAction];
        [self presentViewController: confirmationAlert animated:YES completion:nil];
    }
    else {
        dispatch_queue_t backgroundQueue = dispatch_queue_create("ActionQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL success = methodAction();
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(success) {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:YES
                                                      withColor:[UIColor MPGreenColor]];
                        
                    }];
                }
                else {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:YES
                                                      withColor:[UIColor MPRedColor]];
                    }];
                }
            });
        });
    }
}

- (void) ownerProfileButtonPressed: (id) sender {
    PFUser* owner = self.team[@"owner"];
    [MPControllerManager presentViewController:
     [[MPUserProfileViewController alloc] initWithUser:owner] fromController:self];
}

- (void) promoteMemberButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController membersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    
    [self performModelUpdate:^{
        self.team[@"owner"] = other;
        return [self.team save];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have promoted %@ to be the owner of %@.", other.username, self.team[@"teamName"]]
            withErrorMessage:@"There was an error promoting your new owner. Please try again later."
       withConfirmationAlert:YES
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to promote %@ to be the owner of your team? This cannot be undone.", other.username]];
}

- (void) memberProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController membersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:
     [[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeMemberButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController membersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    
    BOOL shouldConfirm = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    
    [self performModelUpdate:^{
        return [MPTeamsModel leaveTeam:self.team forUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have removed %@ from your team, %@.", other.username, self.team[@"teamName"]]
            withErrorMessage:@"There was an error removing the user. Please try again later."
       withConfirmationAlert:shouldConfirm
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to remove %@ from your team?", other.username]];}

- (void) invitedProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController invitedHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:
     [[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) cancelInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController invitedHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    
    BOOL shouldConfirm = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    
    [self performModelUpdate:^{
        return [MPTeamsModel denyInviteFromTeam:self.team forUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have canceled the invite to %@.", other.username]
            withErrorMessage:@"There was an error canceling the invite. Please try again later."
       withConfirmationAlert: shouldConfirm
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to cancel your invite to %@ to join your team?", other.username]];
}

- (void) acceptRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController requestedHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    
    [self performModelUpdate:^{
        return [MPTeamsModel acceptJoinRequestForTeam:self.team forUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have accepted %@'s request to join %@.", other.username, self.team[@"teamName"]]
            withErrorMessage:@"There was an error accepting the request. Please try again later."
       withConfirmationAlert:NO
     withConfirmationMessage:nil];
}

- (void) requestedProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController requestedHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:
     [[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) denyRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamRosterViewController requestedHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    
    BOOL shouldConfirm = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    
    [self performModelUpdate:^{
        return [MPTeamsModel denyJoinRequestForTeam:self.team forUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have denied %@'s request to join your team.", other.username]
            withErrorMessage:@"There was an error denying the request. Please try again later."
       withConfirmationAlert: shouldConfirm
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to deny %@'s request to join your team?", other.username]];
}

#pragma mark bottom buttons

- (void) makeBottomButtonActions {
    MPTeamRosterView* view = (MPTeamRosterView*)self.view;
    [view.leftButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [view.rightButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    [view.leftButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    switch (self.status) {
        case MPTeamStatusOwner:
            [view.rightButton addTarget:self action:@selector(ownerSettingsButtonPressed:) forControlEvents:UIControlEventAllEvents];
            break;
        case MPTeamStatusMember:
            [view.rightButton addTarget:self action:@selector(leaveTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case MPTeamStatusInvited:
            [view.rightButton addTarget:self action:@selector(respondToInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case MPTeamStatusRequested:
            [view.rightButton addTarget:self action:@selector(cancelRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case MPTeamStatusNonMember:
            [view.rightButton addTarget:self action:@selector(requestJoinButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerManager dismissViewController:self];
}

- (void) leaveTeamButtonPressed: (id) sender {
    [self performModelUpdate:^{
        return [MPTeamsModel leaveTeam:self.team forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have left the team, %@.", self.team[@"teamName"]]
            withErrorMessage:@"There was an error leaving the team. Please try again later."
       withConfirmationAlert:NO
     withConfirmationMessage:nil];
}

- (void) respondToInviteButtonPressed: (id) sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Team Invitation" message:[NSString stringWithFormat:@"You have been invited to the team, %@. Would you like to accept or deny the invite?", self.team[@"teamName"]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* accept = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        [self performModelUpdate:^{
            return [MPTeamsModel acceptInviteFromTeam:self.team forUser:[PFUser currentUser]];
        }
              withSuccessMessage:[NSString stringWithFormat:@"You have accepted the invite to join %@.", self.team[@"teamName"]]
                withErrorMessage:@"There was an error accepting the invite. Please try again later."
           withConfirmationAlert:NO
         withConfirmationMessage:nil];
    }];
    UIAlertAction* deny = [UIAlertAction actionWithTitle:@"Deny" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* handler) {
        [self performModelUpdate:^{
            return [MPTeamsModel denyInviteFromTeam:self.team forUser:[PFUser currentUser]];
        }
              withSuccessMessage:[NSString stringWithFormat:@"You have denied the invite to join %@.", self.team[@"teamName"]]
                withErrorMessage:@"There was an error denying the invite. Please try again later."
           withConfirmationAlert:NO
         withConfirmationMessage:nil];
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction: accept];
    [alert addAction: deny];
    [alert addAction: cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) cancelRequestButtonPressed: (id) sender {
    [self performModelUpdate:^{
        return [MPTeamsModel denyJoinRequestForTeam:self.team forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have canceled your request to join %@.", self.team[@"teamName"]]
            withErrorMessage:@"There was an error canceling your request. Please try again later."
       withConfirmationAlert:NO
     withConfirmationMessage:nil];
}

- (void) requestJoinButtonPressed: (id) sender {
    [self performModelUpdate:^{
        return [MPTeamsModel requestToJoinTeam:self.team forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have requested to join %@.", self.team[@"teamName"]]
            withErrorMessage:@"There was an error processing your request. Please try again later."
       withConfirmationAlert:NO
     withConfirmationMessage:nil];
}

- (void) ownerSettingsButtonPressed: (id) sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Owner Settings" message:@"Select an option below." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* inviteMembersAction = [UIAlertAction actionWithTitle:@"Invite More Members" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
    }];
    UIAlertAction* messageMembersAction = [UIAlertAction actionWithTitle:@"Message Members" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
    }];
    UIAlertAction* renameAction = [UIAlertAction actionWithTitle:@"Rename Team" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
    }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Delete Team" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* handler) {
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction: inviteMembersAction];
    [alert addAction: messageMembersAction];
    [alert addAction: renameAction];
    [alert addAction: deleteAction];
    [alert addAction: cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark strings

+ (NSString*) usersReuseIdentifier { return @"UsersIdentifier"; }

+ (NSString*) ownerHeader { return @"OWNER"; }
+ (NSString*) membersHeader { return @"MEMBERS"; }
+ (NSString*) invitedHeader { return @"INVITED MEMBERS"; }
+ (NSString*) requestedHeader { return @"MEMBERS REQUESTED TO JOIN"; }

@end
