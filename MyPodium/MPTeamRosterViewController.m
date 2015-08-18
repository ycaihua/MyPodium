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
                            }],];
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
