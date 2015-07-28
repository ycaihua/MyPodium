//
//  MPRuleParticipantsPerMatchView.h
//  MyPodium
//
//  Created by Connor Neville on 7/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;

@interface MPRuleParticipantsPerMatchView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPLabel* participantsPerMatchCounter;
@property UIButton* decrementButton;
@property UIButton* incrementButton;

@end
