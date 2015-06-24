//
//  MPFriendsView.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;
@class MPTableHeader;

@interface MPFriendsView : MPMenuView

@property MPSearchControl* filterSearch;
@property MPTableHeader* loadingHeader;
@property UITableView* friendsTable;

+ (NSString*) defaultSubtitle;

@end
