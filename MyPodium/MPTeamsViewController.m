//
//  MPTeamsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPTeamsModel.h"
#import "MPGlobalModel.h"

#import "MPTeamsView.h"
#import "MPTeamCell.h"
#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPTeamsViewController.h"
#import "MPMakeTeamViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPTeamsViewController ()

@end

@implementation MPTeamsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPTeamsView* view = [[MPTeamsView alloc] init];
        self.view = view;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeControlActions];
        [self makeTableSections];
        UITableView* table = view.teamsTable;
        [table registerClass:[MPTeamCell class]
      forCellReuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPTeamsViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [view finishLoading];
        [self refreshData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamsViewController ownedTeamsHeader]
                            withDataBlock:^(){
                                NSArray* ownedTeams = [MPTeamsModel teamsCreatedByUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPTeamsView* view = (MPTeamsView*) self.view;
                                    return [MPGlobalModel teamList:ownedTeams searchForString:view.filterSearch.searchField.text];
                                }
                                else return ownedTeams;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
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
                            initWithHeaderTitle:[MPTeamsViewController teamsAsMemberHeader]
                            withDataBlock:^(){
                                NSArray* teams = [MPTeamsModel teamsContainingUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPTeamsView* view = (MPTeamsView*) self.view;
                                    return [MPGlobalModel teamList:teams searchForString:view.filterSearch.searchField.text];
                                }
                                else return teams;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
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
                                [cell.rightButton addTarget:self action:@selector(leaveMemberTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamsViewController teamsInvitingHeader]
                            withDataBlock:^(){
                                NSArray* teams = [MPTeamsModel teamsInvitingUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPTeamsView* view = (MPTeamsView*) self.view;
                                    return [MPGlobalModel teamList:teams searchForString:view.filterSearch.searchField.text];
                                }
                                else return teams;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
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
                                [cell.leftButton addTarget:self action:@selector(acceptTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(teamInviteProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(denyTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamsViewController teamsRequestedToJoinHeader]
                            withDataBlock:^(){
                                NSArray* teams = [MPTeamsModel teamsRequestedByUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPTeamsView* view = (MPTeamsView*) self.view;
                                    return [MPGlobalModel teamList:teams searchForString:view.filterSearch.searchField.text];
                                }
                                else return teams;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
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
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           ];
}

- (void) loadOnDismiss: (id) sender {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ReloadQueue", 0);
    dispatch_async(backgroundQueue, ^{
        MPTeamsView* view = (MPTeamsView*) self.view;
        [self refreshData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.teamsTable reloadData];
        });
    });
}

- (void) refreshData {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    dispatch_queue_t backgroundQueue = dispatch_queue_create("RefreshQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* section in self.tableSections) {
            [section reloadData];
        }
        [self updateHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.teamsTable reloadData];
            [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
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
        [headerNames addObject: [MPTeamsViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

- (void) makeControlActions {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.searchButton addTarget: self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.makeTeamButton addTarget:self action:@selector(makeTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) searchButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    if(view.searchAvailable) {
        [view hideSearch];
    }
    else {
        [view displaySearch];
    }
}

- (void) makeTeamButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMakeTeamViewController alloc] init] fromController:self];
}

#pragma mark cell targets

- (void) performModelUpdate: (BOOL (^)(void)) methodAction
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
      withConfirmationAlert: (BOOL) showAlert
    withConfirmationMessage: (NSString*) alertMessage {
    MPTeamsView* view = (MPTeamsView*) self.view;
    
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
                        view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                        [self searchButtonPressed: self];
                        [view.teamsTable reloadData];
                    }
                    else {
                        view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                        [view.teamsTable reloadData];
                    }
                });
            });
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
            [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle] revertAfter:false withColor:[UIColor whiteColor]];
            
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
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage: successMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                }
                [view.teamsTable reloadData];
            });
        });
    }
}

- (void) ownedTeamProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) leaveOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController ownedTeamsHeader]];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController ownedTeamsHeader]];
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

- (void) leaveMemberTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsAsMemberHeader]];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsInvitingHeader]];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsInvitingHeader]];
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
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsRequestedToJoinHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyTeamJoinRequest:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your join request for %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:true
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to cancel your join request for the team %@?", other[@"teamName"]]];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPTeamsViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPTeamsViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController blankReuseIdentifier]];
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
    if([self.sectionHeaderNames[section] isEqualToString:[MPTeamsViewController noneFoundHeader]])
        return 1;
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.sectionHeaderNames[section]];
    return  sectionUtility.dataObjects.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTeamCell cellHeight];
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
    MPTeamsView* view = (MPTeamsView*) self.view;
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


+ (NSString*) ownedTeamsHeader { return @"OWNED TEAMS"; }
+ (NSString*) teamsAsMemberHeader { return @"TEAMS I'M ON"; }
+ (NSString*) teamsInvitingHeader { return @"TEAMS INVITING ME"; }
+ (NSString*) teamsRequestedToJoinHeader { return @"TEAMS I REQUESTED TO JOIN"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) teamsReuseIdentifier { return @"TeamsCell"; }
+ (NSString*) blankReuseIdentifier { return @"BlankCell"; }
@end
