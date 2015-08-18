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
    dispatch_async(dispatch_get_main_queue(), ^{
        [view refreshControlsForTeamUpdate];
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

#pragma mark buton actions

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
    
    UIAlertController* confirm = [UIAlertController alertControllerWithTitle:@"Confirmation" message:
                                  [NSString stringWithFormat:@"Are you sure you want to promote %@ to be the owner of your team? This cannot be undone.", other.username] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        MPTeamRosterView* view = (MPTeamRosterView*)self.view;
        [view startLoading];
        dispatch_async(dispatch_queue_create("PromoteQueue", 0), ^{
            self.team[@"owner"] = other;
            view.teamStatus = MPTeamStatusMember;
            BOOL success = [self.team save];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success) {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:@"You have promoted %@ to be the owner of %@.", other.username, self.team[@"teamName"]]
                                                    revertAfter:YES
                                                      withColor:[UIColor MPGreenColor]];
                        
                    }];
                }
                else {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:@"There was an error promoting your new owner. Please try again later."
                                                    revertAfter:YES
                                                      withColor:[UIColor MPRedColor]];
                        
                    }];
                    
                }
            });
        });
    }];
    [confirm addAction: confirmAction];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirm addAction: cancelAction];
    
    [self presentViewController:confirm animated:YES completion:nil];
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
    
    UIAlertController* confirm = [UIAlertController alertControllerWithTitle:@"Confirmation" message:
                                  [NSString stringWithFormat:@"Are you sure you want to remove %@ from your team?", other.username] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
        MPTeamRosterView* view = (MPTeamRosterView*)self.view;
        [view startLoading];
        dispatch_async(dispatch_queue_create("RemoveQueue", 0), ^{
            BOOL success = [MPTeamsModel leaveTeam:self.team forUser:other];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success) {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:@"You have removed %@ from your team.", other.username]
                                                    revertAfter:YES
                                                      withColor:[UIColor MPGreenColor]];
                        
                    }];
                }
                else {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [MPTeamRosterView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:@"There was an error removing the team member. Please try again later."
                                                    revertAfter:YES
                                                      withColor:[UIColor MPRedColor]];
                        
                    }];
                    
                }
            });
        });
    }];
    [confirm addAction: confirmAction];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirm addAction: cancelAction];
    
    [self presentViewController:confirm animated:YES completion:nil];
}

#pragma mark strings

+ (NSString*) usersReuseIdentifier { return @"UsersIdentifier"; }

+ (NSString*) ownerHeader { return @"OWNER"; }
+ (NSString*) membersHeader { return @"MEMBERS"; }
+ (NSString*) invitedHeader { return @"INVITED MEMBERS"; }
+ (NSString*) requestedHeader { return @"MEMBERS REQUESTED TO JOIN"; }

@end
