//
//  MPSearchViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@interface MPSearchViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property NSDictionary* tableSections;

@property NSArray* matchingFriends;
@property NSArray* matchingIncomingRequests;
@property NSArray* matchingOutgoingRequests;
@property NSArray* matchingUsers;
@property NSArray* matchingOwnedTeams;
@property NSArray* matchingTeamsAsMember;
@property NSArray* matchingTeamsInvitingUser;
@property NSArray* matchingTeamsRequestedToJoin;
@property NSArray* matchingVisibleTeams;
@property NSMutableArray* sectionHeaderNames;

@end
