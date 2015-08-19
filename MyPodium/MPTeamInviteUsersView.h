//
//  MPTeamInviteUsersView.h
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class PFObject;
@class MPLabel;
@class MPBottomEdgeButton;

@interface MPTeamInviteUsersView : MPMenuView

@property PFObject* team;
@property NSInteger remainingSpots;

- (id) initWithTeam: (PFObject*) team withRemainingSpots: (NSInteger) remainingSpots;
- (void) updateForRemainingSpots;

@property MPLabel* infoLabel;
@property UITableView* friendsTable;
@property MPBottomEdgeButton* leftButton;
@property MPBottomEdgeButton* rightButton;

@end
