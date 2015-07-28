//
//  MPRuleParticipantView.h
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;
@class MPRuleButton;

@interface MPRuleParticipantView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPRuleButton* participantsButton;
@property MPLabel* playersPerTeamTitle;
@property MPLabel* playersPerTeamLabel;
@property MPLabel* playersPerTeamCounter;
@property UIButton* decrementButton;
@property UIButton* incrementButton;

@end
