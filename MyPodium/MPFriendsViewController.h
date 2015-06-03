//
//  MPFriendsViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@interface MPFriendsViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray* incomingPendingList;
@property NSArray* outgoingPendingList;
@property NSArray* friendsList;

@property NSMutableArray* sectionHeaderNames;

+ (NSString*) incomingPendingHeader;
+ (NSString*) outgoingPendingHeader;
+ (NSString*) friendsHeader;

@end