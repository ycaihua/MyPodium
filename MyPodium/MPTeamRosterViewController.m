//
//  MPTeamRosterViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTableSectionUtility.h"
#import "MPControllerManager.h"

#import "MPTeamRosterView.h"
#import "MPTableViewCell.h"
#import "MPTableHeader.h"

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
                                    return [MPTeamsModel membersForTeam: self.team];
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

#pragma mark strings

+ (NSString*) usersReuseIdentifier { return @"UsersIdentifier"; }

+ (NSString*) ownerHeader { return @"OWNER"; }
+ (NSString*) membersHeader { return @"MEMBERS"; }
+ (NSString*) invitedHeader { return @"INVITED MEMBERS"; }
+ (NSString*) requestedHeader { return @"MEMBERS REQUESTED TO JOIN"; }

@end
