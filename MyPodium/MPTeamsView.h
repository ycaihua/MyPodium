//
//  MPTeamsView.h
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;
@class MPTableHeader;
@class MPBottomEdgeButton;

@interface MPTeamsView : MPMenuView

@property MPTableHeader* loadingHeader;
@property MPSearchControl* filterSearch;
@property UITableView* teamsTable;
@property MPBottomEdgeButton* searchButton;
@property MPBottomEdgeButton* makeTeamButton;

@property BOOL searchAvailable;
- (void) displaySearch;
- (void) hideSearch;
- (void) finishLoading;

+ (NSString*) defaultSubtitle;

@end
