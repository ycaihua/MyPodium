//
//  MPEventsView.h
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;
@class MPTableHeader;
@class MPBottomEdgeButton;

@interface MPEventsView : MPMenuView

@property MPSearchControl* filterSearch;
@property UITableView* eventsTable;
@property MPBottomEdgeButton* searchButton;
@property MPBottomEdgeButton* makeEventButton;

@property BOOL searchAvailable;
- (void) displaySearch;
- (void) hideSearch;
- (void) finishLoading;

@end