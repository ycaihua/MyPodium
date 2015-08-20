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
#import "MPLimitConstants.h"
#import "MPErrorAlerter.h"

#import "MPTeamRosterView.h"
#import "MPTableViewCell.h"
#import "MPTableHeader.h"
#import "MPLabel.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPBottomEdgeButton.h"
#import "MPMessageComposerView.h"

#import "MPUserProfileViewController.h"
#import "MPTeamRosterViewController.h"
#import "MPMessageComposerViewController.h"
#import "MPTeamInviteUsersViewController.h"

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
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to remove %@ from your team?", other.username]
      shouldShowConfirmation:shouldConfirm];
}

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
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to cancel your invite to %@ to join your team?", other.username]
      shouldShowConfirmation:shouldConfirm];
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
            withErrorMessage:@"There was an error accepting the request. Please try again later."];
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
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to deny %@'s request to join your team?", other.username]
      shouldShowConfirmation:shouldConfirm];
}

#pragma mark bottom buttons

- (void) makeBottomButtonActions {
    MPTeamRosterView* view = (MPTeamRosterView*)self.view;
    [view.leftButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [view.rightButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    [view.leftButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    switch (self.status) {
        case MPTeamStatusOwner:
            [view.rightButton addTarget:self action:@selector(ownerSettingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
            withErrorMessage:@"There was an error leaving the team. Please try again later."];
}

- (void) respondToInviteButtonPressed: (id) sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Team Invitation" message:[NSString stringWithFormat:@"You have been invited to the team, %@. Would you like to accept or deny the invite?", self.team[@"teamName"]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* accept = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        [self performModelUpdate:^{
            return [MPTeamsModel acceptInviteFromTeam:self.team forUser:[PFUser currentUser]];
        }
              withSuccessMessage:[NSString stringWithFormat:@"You have accepted the invite to join %@.", self.team[@"teamName"]]
                withErrorMessage:@"There was an error accepting the invite. Please try again later."];
    }];
    UIAlertAction* deny = [UIAlertAction actionWithTitle:@"Deny" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* handler) {
        [self performModelUpdate:^{
            return [MPTeamsModel denyInviteFromTeam:self.team forUser:[PFUser currentUser]];
        }
              withSuccessMessage:[NSString stringWithFormat:@"You have denied the invite to join %@.", self.team[@"teamName"]]
                withErrorMessage:@"There was an error denying the invite. Please try again later."];
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
            withErrorMessage:@"There was an error canceling your request. Please try again later."];
}

- (void) requestJoinButtonPressed: (id) sender {
    [self performModelUpdate:^{
        return [MPTeamsModel requestToJoinTeam:self.team forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You have requested to join %@.", self.team[@"teamName"]]
            withErrorMessage:@"There was an error processing your request. Please try again later."];
}

- (void) ownerSettingsButtonPressed: (id) sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Owner Settings" message:@"Select an option below." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* inviteMembersAction = [UIAlertAction actionWithTitle:@"Invite More Members" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        dispatch_async(dispatch_queue_create("VerifyMemberCountQueue", 0), ^{
            MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
            [alerter checkErrorCondition:([MPTeamsModel countRemainingOpeningsOnTeam:self.team] == 0) withMessage:@"You currently have the maximum number of slots filled for your team. Remove existing members or cancel invitations to make more room."];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(![alerter hasFoundError])
                    [MPControllerManager presentViewController:[[MPTeamInviteUsersViewController alloc] initWithTeam:self.team] fromController:self];
            });
        });
    }];
    UIAlertAction* messageMembersAction = [UIAlertAction actionWithTitle:@"Message Members" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        [self messageMembers];
    }];
    UIAlertAction* renameAction = [UIAlertAction actionWithTitle:@"Rename Team" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        [self displayRenameAlert];
    }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Delete Team" style:UIAlertActionStyleDestructive handler:^(UIAlertAction* handler) {
        [self confirmDeleteTeam];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction: inviteMembersAction];
    [alert addAction: messageMembersAction];
    [alert addAction: renameAction];
    [alert addAction: deleteAction];
    [alert addAction: cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) messageMembers {
    dispatch_async(dispatch_queue_create("MembersStringQueue", 0), ^{
        NSString* membersString = [self stringFromMemberNames];
        dispatch_async(dispatch_get_main_queue(), ^{
            MPMessageComposerViewController* destination = [[MPMessageComposerViewController alloc] init];
            MPMessageComposerView* view = (MPMessageComposerView*)destination.view;
            view.recipientsField.text = membersString;
            [MPControllerManager presentViewController:destination fromController:self];
        });
    });
}

- (void) displayRenameAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Rename Team" message:[NSString stringWithFormat:@"Enter your team's new name. It must be between %d-%d characters.", [MPLimitConstants minTeamNameCharacters], [MPLimitConstants maxTeamNameCharacters]] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField* field) {
        field.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }];
    
    UIAlertAction* submit = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        NSString* text = [alert.textFields objectAtIndex:0].text;
        MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
        [alerter checkErrorCondition:(text.length > [MPLimitConstants maxTeamNameCharacters]) withMessage:[NSString stringWithFormat:@"The team name you entered was too short (minimum %d characters).", [MPLimitConstants minTeamNameCharacters]]];
        [alerter checkErrorCondition:(text.length > [MPLimitConstants maxTeamNameCharacters]) withMessage:[NSString stringWithFormat:@"The team name you entered was too long (max %d characters).", [MPLimitConstants maxTeamNameCharacters]]];
        if(![alerter hasFoundError]) {
            [self performModelUpdate:^{
                self.team[@"teamName"] = text;
                self.team[@"teamName_searchable"] = text.lowercaseString;
                return [self.team save];
            }
                  withSuccessMessage:[NSString stringWithFormat:@"You have changed your team's name to %@.", text]
                    withErrorMessage:@"There was an error processing your request. Please try again later."];
        }
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction: submit];
    [alert addAction: cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) confirmDeleteTeam {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Are you sure you want to delete your team, %@? This cannot be undone.",self.team[@"teamName"]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        dispatch_async(dispatch_queue_create("DeleteQueue", 0), ^{
            BOOL success = [MPTeamsModel deleteTeam: self.team];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success) {
                    [MPControllerManager dismissViewController: self];
                }
                else {
                    MPTeamRosterView* view = (MPTeamRosterView*)self.view;
                    [view.menu.subtitleLabel displayMessage:@"There was an error deleting your team. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction: confirmAction];
    [alert addAction: cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark message composer

//Will stall main queue if not called inside background thread
- (NSString*) stringFromMemberNames {
    NSArray* members = [MPTeamsModel membersForTeam: self.team];
    PFUser* firstUser = members[0];
    NSString* membersString = firstUser.username;
    for(int i = 1; i < members.count; i++) {
        PFUser* currentUser = members[i];
        membersString = [membersString stringByAppendingString:
                         [NSString stringWithFormat:@", %@", currentUser.username]];
    }
    return membersString;
}

#pragma mark strings

+ (NSString*) usersReuseIdentifier { return @"UsersIdentifier"; }

+ (NSString*) ownerHeader { return @"OWNER"; }
+ (NSString*) membersHeader { return @"MEMBERS"; }
+ (NSString*) invitedHeader { return @"INVITED MEMBERS"; }
+ (NSString*) requestedHeader { return @"MEMBERS REQUESTED TO JOIN"; }

@end
