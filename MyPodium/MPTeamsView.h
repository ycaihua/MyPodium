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
@class MPTeamsButton;

@interface MPTeamsView : MPMenuView

@property MPSearchView* filterSearch;
@property UITableView* teamsTable;
@property MPTeamsButton* searchButton;
@property MPTeamsButton* makeTeamButton;

@property BOOL searchAvailable;
- (void) displaySearch;
- (void) hideSearch;

+ (NSString*) defaultSubtitle;

@end
