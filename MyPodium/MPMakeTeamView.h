//
//  MPMakeTeamView.h
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPTextField;
@class MPBottomEdgeButton;
@class MPLabel;

@interface MPMakeTeamView : MPMenuView

@property MPTextField* teamNameField;
@property MPLabel* instructionLabel;
@property UITableView* playersTable;
@property MPBottomEdgeButton* goBackButton;
@property MPBottomEdgeButton* submitButton;

@end