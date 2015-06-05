//
//  MPFriendsView.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPFriendsHeader.h"
#import "MPSearchView.h"

@interface MPFriendsView : MPMenuView

@property MPSearchView* filterSearch;
@property MPFriendsHeader* loadingHeader;
@property UITableView* friendsTable;

+ (NSString*) defaultSubtitle;

@end
