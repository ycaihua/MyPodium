//
//  MPSearchViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@interface MPSearchViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property NSArray* matchingFriends;
@property NSArray* matchingPendingRequests;
@property NSArray* matchingUsers;
@property NSArray* matchingTeams;
@property NSMutableArray* sectionHeaderNames;

@end
