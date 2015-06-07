//
//  MPUserSearchView.h
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
@class MPSearchView;

@interface MPUserSearchView : MPMenuView

@property MPSearchView* searchView;
@property UITableView* searchTable;

+ (NSString*) defaultSubtitle;

@end
