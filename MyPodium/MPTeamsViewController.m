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
#import "MPTableViewCell.h"
#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPTeamsViewController.h"
#import "MPTeamRosterViewController.h"
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
        self.delegate = self;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeControlActions];
        [self makeTableSections];
        UITableView* table = view.teamsTable;
        [table registerClass:[MPTableViewCell class]
      forCellReuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPTeamsViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [self reloadData];
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
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:3];
                                [cell clearButtonActions];
                                
                                [cell setButtonImageStrings:@[@[@"minus", @"red"], @[@"info", @"yellow"], @[@"x", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[2] addTarget:self action:@selector(leaveOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[1] addTarget:self action:@selector(ownedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(deleteOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withTeamObject:object];
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
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"], @[@"minus", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(memberTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(leaveMemberTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withTeamObject:object];
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
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:3];
                                [cell clearButtonActions];
                                
                                [cell setButtonImageStrings:@[@[@"check", @"green"], @[@"info", @"yellow"], @[@"x", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[2] addTarget:self action:@selector(acceptTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[1] addTarget:self action:@selector(teamInviteProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(denyTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withTeamObject:object];
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
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                
                                //Set images
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"], @[@"minus", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(requestedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(cancelTeamRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withTeamObject:object];
                            }],
                           ];
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPTeamsViewController* teamsVC = (MPTeamsViewController*) controller;
    for(MPTableSectionUtility* section in teamsVC.tableSections) {
        [section reloadData];
    }
    [teamsVC updateHeaders];
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPTeamsViewController* teamsVC = (MPTeamsViewController*) controller;
    MPTeamsView* view = (MPTeamsView*)teamsVC.view;
    return view.teamsTable;
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
                            view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                            view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                            [view.menu.subtitleLabel displayMessage: successMessage
                                                        revertAfter:TRUE
                                                          withColor:[UIColor MPGreenColor]];
                            
                        }];
                    }
                    else {
                        [self reloadDataWithCompletionBlock:^{
                            view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                            view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                            [view.menu.subtitleLabel displayMessage:errorMessage
                                                        revertAfter:TRUE
                                                          withColor:[UIColor MPRedColor]];
                        }];
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
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                        
                    }];
                }
                else {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                    }];
                }
            });
        });
    }
}

- (void) ownedTeamProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) leaveOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You left your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:showConfirmation
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to leave your team, %@? A new owner will be chosen.", other[@"teamName"]]];
}

- (void) deleteOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel deleteTeam: other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:showConfirmation
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to delete your team, %@? This cannot be undone.", other[@"teamName"]]];
}

- (void) memberTeamProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsAsMemberHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) leaveMemberTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsAsMemberHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You left your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:showConfirmation
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to leave your team, %@? If you are the owner, a new owner will be assigned if possible.", other[@"teamName"]]];
}

- (void) acceptTeamInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsInvitingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel acceptInviteFromTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You joined the team %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:NO
     withConfirmationMessage:@""];
}

- (void) teamInviteProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsInvitingHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) denyTeamInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsInvitingHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyInviteFromTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You denied the team invite from %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:showConfirmation
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to deny the invitation from %@?", other[@"teamName"]]];
}

- (void) requestedTeamProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsRequestedToJoinHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) cancelTeamRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPTeamsViewController teamsRequestedToJoinHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyJoinRequestForTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your join request for %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:showConfirmation
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
    return [MPTableViewCell cellHeight];
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

#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.filterSearch.searchField resignFirstResponder];
    NSString* filterString = view.filterSearch.searchField.text;
    self.isFiltered = !(filterString.length == 0);
    [self reloadData];
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
