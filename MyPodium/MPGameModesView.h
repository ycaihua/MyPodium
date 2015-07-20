//
//  MPGameModesView.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;
@class MPTableHeader;
@class MPBottomEdgeButton;

@interface MPGameModesView : MPMenuView

@property MPSearchControl* filterSearch;
@property UITableView* modesTable;
@property MPBottomEdgeButton* searchButton;
@property MPBottomEdgeButton* makeGameModeButton;

@property BOOL searchAvailable;
- (void) displaySearch;
- (void) hideSearch;
- (void) finishLoading;

+ (NSString*) defaultSubtitle;

@end