//
//  MPMakeTeamView.h
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPTextField;

@interface MPMakeTeamView : MPMenuView

@property MPTextField* teamNameField;
@property UITableView* playersTable;
@property UIButton* submitButton;

@end
