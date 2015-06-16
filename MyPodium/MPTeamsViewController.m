//
//  MPTeamsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPTeamsModel.h"

#import "MPTeamsView.h"
#import "MPTeamCell.h"
#import "MPTeamsButton.h"
#import "MPTableHeader.h"
#import "MPSearchView.h"
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
        [self loadDataAndUpdate];
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;        [self makeControlActions];
    }
    return self;
}

- (void) loadDataAndUpdate {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    //Data init (in background)
    dispatch_queue_t backgroundQueue = dispatch_queue_create("TeamsQueue", 0);
    dispatch_async(backgroundQueue, ^{
        self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
        PFUser* user = [PFUser currentUser];
        self.invitesList = [MPTeamsModel teamsInvitingUser:user];
        self.teamsOwnedList = [MPTeamsModel teamsCreatedByUser:user];
        self.allTeamsList = [MPTeamsModel teamsContainingUser:user];
        [self updateUnfilteredHeaders];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Table UI init once data is retrieved
            UITableView* table = view.teamsTable;
            [table registerClass:[MPTeamCell class]
          forCellReuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
            table.delegate = self;
            table.dataSource = self;
            [view finishLoading];
            [table reloadData];
        });
    });
}

- (void) updateUnfilteredHeaders {
    self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
    if(self.invitesList.count > 0)
        [self.sectionHeaderNames addObject:[MPTeamsViewController invitesHeader]];
    if(self.teamsOwnedList.count > 0)
        [self.sectionHeaderNames addObject:[MPTeamsViewController teamsOwnedHeader]];
    if(self.allTeamsList.count > 0)
        [self.sectionHeaderNames addObject:[MPTeamsViewController allTeamsHeader]];
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
        view.filterSearch.searchField.text = @"";
        self.isFiltered = NO;
        [self updateUnfilteredHeaders];
        [view.teamsTable reloadData];
    }
    else {
        [view displaySearch];
    }
}

- (void) makeTeamButtonPressed: (id) sender {
    MPMakeTeamViewController* destination = [[MPMakeTeamViewController alloc] init];
    [self presentViewController:[AppDelegate makeDrawerWithCenterController:destination] animated:true completion:nil];
    [destination addMenuActions];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    
    PFObject* team;
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPTeamsViewController invitesHeader]]) {
        
        if(self.isFiltered)
            team = self.invitesFilteredList[indexPath.row];
        else
            team = self.invitesList[indexPath.row];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPTeamsViewController teamsOwnedHeader]]) {
        if(self.isFiltered)
            team = self.teamsOwnedFilteredList[indexPath.row];
        else
            team = self.teamsOwnedList[indexPath.row];
    }
    else {
        if(self.isFiltered)
            team = self.allTeamsFilteredList[indexPath.row];
        else
            team = self.allTeamsList[indexPath.row];
    }
    //Update data for appropriate user
    [cell updateForTeam: team];
    
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPTeamsViewController invitesHeader]]) {
        [cell.leftButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(acceptInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(denyInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPTeamsViewController teamsOwnedHeader]]) {
        [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
        //Add targets
        [cell.rightButton addTarget:self action:@selector(deleteTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
        [cell.rightButton addTarget:self action:@selector(leaveTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:
        [MPTeamsViewController invitesHeader]]) {
        if(self.isFiltered)
            return self.invitesFilteredList.count;
        else
            return self.invitesList.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPTeamsViewController teamsOwnedHeader]]) {
        if(self.isFiltered)
            return self.teamsOwnedFilteredList.count;
        else
            return self.teamsOwnedList.count;
    }
    else {
        if(self.isFiltered)
            return self.allTeamsFilteredList.count;
        else
            return self.allTeamsList.count;
    }
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

#pragma mark button actions

- (void) acceptInviteButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    PFObject* other;
    if(self.isFiltered) {
        other = self.invitesFilteredList[indexPath.row];
    }
    else {
        other = self.invitesList[indexPath.row];
    }
    
    //Background thread
    dispatch_queue_t backgroundQueue = dispatch_queue_create("AcceptTeamQueue", 0);
    dispatch_async(backgroundQueue, ^{
        
        BOOL acceptSuccess = [MPTeamsModel acceptInviteFromTeam: other forUser:[PFUser currentUser]];
        //If accept success, first update controller data
        //from model data
        if(acceptSuccess) {
            self.isFiltered = NO;
            
            NSMutableArray* newInvitesList = self.invitesList.mutableCopy;
            [newInvitesList removeObject: other];
            if(newInvitesList.count == 0)
                [self.sectionHeaderNames removeObject:
                 [MPTeamsViewController invitesHeader]];
            self.invitesList = newInvitesList;
            
            NSMutableArray* newAllTeams = self.allTeamsList.mutableCopy;
            [newAllTeams addObject: other];
            if(newAllTeams.count == 1) {
                [self.sectionHeaderNames addObject:
                 [MPTeamsViewController allTeamsHeader]];
            }
            self.allTeamsList = newAllTeams;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update UI, based on success
            if(acceptSuccess) {
                view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:
                                                         @"You accepted a team invite from %@.", other[@"teamName"]]
                                            revertAfter:TRUE
                                              withColor:[UIColor MPGreenColor]];
                [view.teamsTable reloadData];
            }
            else {
                view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                [view.menu.subtitleLabel displayMessage:@"There was an error accepting the invite. Please try again later."
                                            revertAfter:TRUE
                                              withColor:[UIColor MPRedColor]];
                [view.teamsTable reloadData];
            }
        });
    });
}

- (void) denyInviteButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFObject* other;
    if(self.isFiltered) {
        other = self.invitesFilteredList[indexPath.row];
    }
    else {
        other = self.invitesList[indexPath.row];
    }
    
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmDenyAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to deny the team invitation from %@?", other[@"teamName"]]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("DenyTeamQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL denySuccess = [MPTeamsModel denyInviteFromTeam:other forUser:[PFUser currentUser]];
            //If accept success, first update controller data
            //from model data
            if(denySuccess) {
                self.isFiltered = NO;
                NSMutableArray* newInvitesList = self.invitesList.mutableCopy;
                [newInvitesList removeObject: other];
                if(newInvitesList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPTeamsViewController invitesHeader]];
                self.invitesList = newInvitesList;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(denySuccess) {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You denied a team invite from %@.", other[@"teamName"]]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.teamsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error denying the request. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.teamsTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
        [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle]
                                    revertAfter:FALSE
                                      withColor:[UIColor whiteColor]];
    }];
    [confirmDenyAlert addAction: confirmAction];
    [confirmDenyAlert addAction: cancelAction];
    [self presentViewController: confirmDenyAlert animated: true completion:nil];
}

- (void) deleteTeamButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFObject* other;
    if(self.isFiltered) {
        other = self.teamsOwnedFilteredList[indexPath.row];
    }
    else {
        other = self.teamsOwnedList[indexPath.row];
    }
    
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmDenyAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to delete your team, %@? This action cannot be undone.", other[@"teamName"]]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("DeleteTeamQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL deleteSuccess = [MPTeamsModel deleteTeam:other];
            //If success, first update controller data
            //from model data
            if(deleteSuccess) {
                self.isFiltered = NO;
                NSMutableArray* newTeamsOwnedList = self.teamsOwnedList.mutableCopy;
                [newTeamsOwnedList removeObject: other];
                if(newTeamsOwnedList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPTeamsViewController teamsOwnedHeader]];
                self.teamsOwnedList = newTeamsOwnedList;
                
                NSMutableArray* newAllTeamsList = self.allTeamsList.mutableCopy;
                //Because "other" was accessed from teamsOwned, it won't pass the automatic
                //equality test against the "same" team in allTeams. Manual search needed
                int removeIndex = -1;
                for(int i = 0; i < newAllTeamsList.count; i++) {
                    if([[newAllTeamsList[i] objectId] isEqualToString:[other objectId]])
                        removeIndex = i;
                }
                if(newAllTeamsList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPTeamsViewController allTeamsHeader]];
                self.allTeamsList = newAllTeamsList;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(deleteSuccess) {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You deleted your team, %@.", other[@"teamName"]]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.teamsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error removing the team. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.teamsTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
        [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle]
                                    revertAfter:FALSE
                                      withColor:[UIColor whiteColor]];
    }];
    [confirmDenyAlert addAction: confirmAction];
    [confirmDenyAlert addAction: cancelAction];
    [self presentViewController: confirmDenyAlert animated: true completion:nil];
}

- (void) leaveTeamButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPTeamCell* cell = (MPTeamCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFObject* other;
    if(self.isFiltered) {
        other = self.allTeamsFilteredList[indexPath.row];
    }
    else {
        other = self.allTeamsList[indexPath.row];
    }
    
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmDenyAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to leave your team, %@? If you are the creator of the team, a random teammate will be promoted to creator.", other[@"teamName"]]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("LeaveTeamQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL leaveSuccess = [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
            //If success, first update controller data
            //from model data
            if(leaveSuccess) {
                self.isFiltered = NO;
                NSMutableArray* newTeamsOwnedList = self.teamsOwnedList.mutableCopy;
                //Because "other" was accessed from allTeams, it won't pass the automatic
                //equality test against the "same" team in teamsOwned. Manual search needed
                for(PFObject* team in newTeamsOwnedList) {
                    if([[team objectId] isEqualToString:[other objectId]])
                        [newTeamsOwnedList removeObject: team];
                }
                
                if(newTeamsOwnedList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPTeamsViewController teamsOwnedHeader]];
                self.teamsOwnedList = newTeamsOwnedList;
                
                NSMutableArray* newAllTeamsList = self.allTeamsList.mutableCopy;
                [newAllTeamsList removeObject:other];
                if(newAllTeamsList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPTeamsViewController allTeamsHeader]];
                self.allTeamsList = newAllTeamsList;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(leaveSuccess) {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You left your team, %@.", other[@"teamName"]]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.teamsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPTeamsView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error leaving the team. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.teamsTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
        [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle]
                                    revertAfter:FALSE
                                      withColor:[UIColor whiteColor]];
    }];
    [confirmDenyAlert addAction: confirmAction];
    [confirmDenyAlert addAction: cancelAction];
    [self.mm_drawerController presentViewController: confirmDenyAlert animated: true completion:nil];
}

#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.filterSearch.searchField resignFirstResponder];
    NSString* filterString = view.filterSearch.searchField.text;
    if(filterString.length == 0) {
        self.isFiltered = NO;
        [self updateUnfilteredHeaders];
        [view.teamsTable reloadData];
        return;
    }
    [self filterListsWithString: filterString];
    [view.teamsTable reloadData];
}

- (void) filterListsWithString: (NSString*) filterString {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FilterQueue", 0);
    dispatch_async(backgroundQueue, ^{
        self.isFiltered = YES;
        self.invitesFilteredList = [[NSMutableArray alloc] initWithCapacity:
                                            self.invitesList.count];
        self.teamsOwnedFilteredList = [[NSMutableArray alloc] initWithCapacity:
                                            self.teamsOwnedList.count];
        self.allTeamsFilteredList = [[NSMutableArray alloc] initWithCapacity:
                                    self.allTeamsList.count];
        
        MPTeamsView* view = (MPTeamsView*) self.view;
        [view.menu.subtitleLabel displayMessage:@"Filtering..." revertAfter:NO withColor:[UIColor MPYellowColor]];
        
        //Filter invites
        for (PFObject* team in self.invitesList)
        {
            NSString* teamName = team[@"teamName"];
            NSRange teamNameRange = [teamName rangeOfString:filterString options:NSCaseInsensitiveSearch];
            if(teamNameRange.location != NSNotFound)
            {
                [self.invitesFilteredList addObject:team];
            }
        }
        if(self.invitesFilteredList.count == 0)
            [self.sectionHeaderNames removeObject:[MPTeamsViewController invitesHeader]];
        
        //Filter teams owned
        for (PFObject* team in self.teamsOwnedList)
        {
            NSString* teamName = team[@"teamName"];
            NSRange teamNameRange = [teamName rangeOfString:filterString options:NSCaseInsensitiveSearch];
            if(teamNameRange.location != NSNotFound)
            {
                [self.teamsOwnedFilteredList addObject:team];
            }
        }
        if(self.teamsOwnedFilteredList.count == 0)
            [self.sectionHeaderNames removeObject:[MPTeamsViewController teamsOwnedHeader]];
        
        //Filter all teams
        for (PFObject* team in self.allTeamsList)
        {
            NSString* teamName = team[@"teamName"];
            NSRange teamNameRange = [teamName rangeOfString:filterString options:NSCaseInsensitiveSearch];
            if(teamNameRange.location != NSNotFound)
            {
                [self.allTeamsFilteredList addObject:team];
            }
        }
        if(self.allTeamsFilteredList.count == 0)
            [self.sectionHeaderNames removeObject:[MPTeamsViewController allTeamsHeader]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.teamsTable reloadData];
            [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
        });
    });
}

#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    self.isFiltered = NO;
    [self updateUnfilteredHeaders];
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.teamsTable reloadData];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self filterSearchButtonPressed: nil];
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

+ (NSString*) invitesHeader { return @"TEAM INVITES"; }
+ (NSString*) teamsOwnedHeader { return @"TEAMS I OWN"; }
+ (NSString*) allTeamsHeader { return @"ALL TEAMS"; }
+ (NSString*) teamsReuseIdentifier { return @"TeamsCell"; }
@end
