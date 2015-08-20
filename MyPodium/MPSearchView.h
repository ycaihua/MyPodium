//
//  MPSearchView.h
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;

@interface MPSearchView : MPMenuView

@property MPSearchControl* searchView;
@property UITableView* searchTable;

@end
