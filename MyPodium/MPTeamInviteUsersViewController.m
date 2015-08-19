//
//  MPTeamInviteUsersViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>
#import "MPTableSectionUtility.h"
#import "MPControllerManager.h"
#import "UIColor+MPColor.h"
#import "MPErrorAlerter.h"

#import "MPTeamsModel.h"
#import "MPFriendsModel.h"

#import "MPTeamInviteUsersView.h"
#import "MPBottomEdgeButton.h"
#import "MPTableViewCell.h"
#import "MPTableHeader.h"
#import "MPLabel.h"
#import "MPMenu.h"

#import "MPTeamInviteUsersViewController.h"

@interface MPTeamInviteUsersViewController ()

@end

@implementation MPTeamInviteUsersViewController

- (id) initWithTeam:(PFObject *)team {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] initWithTitleText:@"MY PODIUM" subtitleText:@"Loading..."];
        dispatch_async(dispatch_queue_create("CountSpotsQueue", 0), ^{
            NSInteger remainingSpots = [MPTeamsModel countRemainingOpeningsOnTeam: team];
            self.team = team;
            self.remainingSpots = remainingSpots;
            self.eligibleFriends = [self generateEligibleFriends];
            self.selectedFriends = [[NSMutableArray alloc] initWithCapacity: self.eligibleFriends.count];
            dispatch_async(dispatch_get_main_queue(), ^{
                MPTeamInviteUsersView* view = [[MPTeamInviteUsersView alloc] initWithTeam: team withRemainingSpots: remainingSpots];
                self.view = view;
                self.delegate = self;
                [view.friendsTable registerClass:[MPTableViewCell class] forCellReuseIdentifier:[MPTeamInviteUsersViewController userReuseIdentifier]];
                view.friendsTable.delegate = self;
                view.friendsTable.dataSource = self;
                [self addMenuActions];
                [self makeControlActions];
            });
        });
    }
    return self;
}

- (NSArray*) generateEligibleFriends {
    NSArray* allFriends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: allFriends.count];
    for(PFUser* friend in allFriends) {
        MPTeamStatus friendStatus = [MPTeamsModel teamStatusForUser:friend forTeam:self.team];
        if(friendStatus == MPTeamStatusNonMember)
            [results addObject: friend];
    }
    return results;
}

#pragma mark MPDataLoader

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPTeamInviteUsersViewController* inviteVC = (MPTeamInviteUsersViewController*)controller;
    NSInteger remainingSpots = [MPTeamsModel countRemainingOpeningsOnTeam: self.team];
    inviteVC.remainingSpots = remainingSpots;
    
    MPTeamInviteUsersView* view = (MPTeamInviteUsersView*)inviteVC.view;
    view.remainingSpots = remainingSpots;
    dispatch_async(dispatch_get_main_queue(), ^{
        [view updateForRemainingSpots];
    });
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPTeamInviteUsersViewController* inviteVC = (MPTeamInviteUsersViewController*)controller;
    MPTeamInviteUsersView* view = (MPTeamInviteUsersView*)inviteVC.view;
    return view.friendsTable;
}

#pragma mark UITableView

- (UITableViewCell*) tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
     [MPTeamInviteUsersViewController userReuseIdentifier] forIndexPath:indexPath];
    
    if(!cell)
        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamInviteUsersViewController userReuseIdentifier]];
    
    cell.indexPath = indexPath;
    [cell setNumberOfButtons: 0];
    [MPTableSectionUtility updateCell:cell withUserObject:self.eligibleFriends[indexPath.row]];
    
    return cell;
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eligibleFriends.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPTeamInviteUsersView* view = (MPTeamInviteUsersView*) self.view;
    PFUser* friend = self.eligibleFriends[indexPath.row];
    [self.selectedFriends addObject: friend];
    [view.rightButton enable];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPTeamInviteUsersView* view = (MPTeamInviteUsersView*) self.view;
    PFUser* friend = self.eligibleFriends[indexPath.row];
    [self.selectedFriends removeObject: friend];
    if(self.selectedFriends.count == 0)
        [view.rightButton disable];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:@"FRIENDS"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark bottom buttons

- (void) makeControlActions {
    MPTeamInviteUsersView* view = (MPTeamInviteUsersView*) self.view;
    [view.leftButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.rightButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerManager dismissViewController: self];
}

- (void) submitButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    [alerter checkErrorCondition:(self.selectedFriends.count > self.remainingSpots) withMessage:[NSString stringWithFormat:@"You have too many members selected. You can currently invite %ld more members.", (long)self.remainingSpots]];
    if(![alerter hasFoundError]) {
        [self inviteSelectedUsers];
    }
}

- (void) inviteSelectedUsers {
    dispatch_async(dispatch_queue_create("InviteUsersQueue", 0), ^{
        for(PFUser* user in self.selectedFriends) {
            NSString* userID = user.objectId;
            [self.team addObject:userID forKey:@"invitedMembers"];
        }
        BOOL success = [self.team save];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success)
                [MPControllerManager dismissViewController: self];
            else {
                MPTeamInviteUsersView* view = (MPTeamInviteUsersView*) self.view;
                [view.menu.subtitleLabel displayMessage:@"There was an error inviting the users. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
            }
        });
    });
}

#pragma mark strings

+ (NSString*) userReuseIdentifier { return @"UserReuseIdentifier"; }

@end
