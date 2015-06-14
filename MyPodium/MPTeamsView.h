//
//  MPTeamsView.h
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchView;
@class MPTableHeader;

@interface MPTeamsView : MPMenuView

@property MPSearchView* filterSearch;
@property MPTableHeader* loadingHeader;
@property UITableView* teamsTable;

+ (NSString*) defaultSubtitle;

@end
