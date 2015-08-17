//
//  MPRulesView.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;
@class MPTableHeader;
@class MPBottomEdgeButton;

@interface MPRulesView : MPMenuView

@property MPSearchControl* filterSearch;
@property UITableView* rulesTable;
@property MPBottomEdgeButton* searchButton;
@property MPBottomEdgeButton* makeRuleButton;

@property BOOL searchAvailable;
- (void) displaySearch;
- (void) hideSearch;
- (void) finishLoading;

+ (NSString*) defaultSubtitle;

@end