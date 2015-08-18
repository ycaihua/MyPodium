//
//  MPTeamRosterView.h
//  MyPodium
//
//  Created by Connor Neville on 8/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"
#import "MPTeamsModel.h"

@class PFObject;

@class MPLabel;
@class MPBottomEdgeButton;

@interface MPTeamRosterView : MPMenuView

@property PFObject* team;
@property MPTeamStatus teamStatus;

- (id) initWithTeam: (PFObject*) team andTeamStatus: (MPTeamStatus) status;
- (void) refreshControlsForTeamUpdate;

@property MPLabel* titleLabel;
@property MPLabel* statusLabel;
@property UITableView* rosterTable;
@property MPBottomEdgeButton* leftButton;
@property MPBottomEdgeButton* rightButton;

+ (NSString*) defaultSubtitle;

@end
