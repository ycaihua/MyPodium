//
//  MPTeamInviteUsersViewController.h
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@class PFObject;

@interface MPTeamInviteUsersViewController : MPMenuViewController<MPDataLoader, UITableViewDataSource, UITableViewDelegate>

@property PFObject* team;
@property NSInteger remainingSpots;
@property NSArray* eligibleFriends;
@property NSMutableArray* selectedFriends;

- (id) initWithTeam: (PFObject*) team;

@end
