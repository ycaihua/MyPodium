//
//  MPRuleTimerView.h
//  MyPodium
//
//  Created by Connor Neville on 7/29/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;
@class MPRuleButton;

@interface MPRuleTimerView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPRuleButton* timerButton;
@property MPLabel* timerDurationTitle;
@property MPLabel* timerDurationLabel;
@property MPLabel* timerDurationCounter;
@property UIButton* decrementButton;
@property UIButton* incrementButton;

@end
