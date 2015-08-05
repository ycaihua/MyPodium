//
//  MPMakeRuleView.m
//  MyPodium
//
//  Created by Connor Neville on 7/22/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPLabel.h"
#import "MPTextField.h"
#import "MPMakeRuleView.h"
#import "MPRuleNameView.h"
#import "MPRuleParticipantView.h"
#import "MPRuleParticipantsPerMatchView.h"
#import "MPRuleWinConditionStatView.h"
#import "MPRuleWinConditionValueView.h"
#import "MPRuleTimerView.h"
#import "MPRuleStatsView.h"
#import "MPBottomEdgeButton.h"

@implementation MPMakeRuleView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeRuleView defaultSubtitle]];
    if(self) {
        [self makeSlides];
        [self setFirstResponder];
    }
    return self;
}

- (void) makeSlides {
    //self.ruleSubviews
    self.slideViews = @[[[MPRuleNameView alloc] init], [[MPRuleParticipantView alloc] init],[[MPRuleParticipantsPerMatchView alloc] init], [[MPRuleStatsView alloc] init],
                          [[MPRuleWinConditionStatView alloc] init], [[MPRuleWinConditionValueView alloc] init], [[MPRuleTimerView alloc] init]];
    [self addSlideViews];
}

- (void) setFirstResponder {
    MPRuleNameView* nameView = (MPRuleNameView*)[self slideWithClass:[MPRuleNameView class]];
    [nameView.nameField becomeFirstResponder];
}

- (void) advanceToNextSlide {
    [super advanceToNextSlide];
    MPView* newDisplayedView = [self currentSlide];
    if([newDisplayedView isKindOfClass:[MPRuleStatsView class]]) {
        [((MPRuleStatsView*)newDisplayedView).playerStatsField becomeFirstResponder];
    }}

- (void) returnToLastSubview {
    [super advanceToNextSlide];
    MPView* newDisplayedView = [self currentSlide];
    if([newDisplayedView isKindOfClass:[MPRuleNameView class]]) {
        [((MPRuleNameView*)newDisplayedView).nameField becomeFirstResponder];
    }
    else if([newDisplayedView isKindOfClass:[MPRuleStatsView class]]) {
        [((MPRuleStatsView*)newDisplayedView).playerStatsField becomeFirstResponder];
    }
}

+ (NSString*) defaultSubtitle { return @"New Rule"; }

@end
