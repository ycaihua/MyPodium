//
//  MPFriendsView.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPFriendsHeader.h"

@interface MPFriendsView : MPMenuView

@property MPFriendsHeader* loadingHeader;
@property UITableView* friendsTable;

@end
