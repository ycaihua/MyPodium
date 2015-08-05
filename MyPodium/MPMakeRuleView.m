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
#import "MPFormView.h"
#import "MPMakeRuleView.h"
#import "MPRuleNameView.h"
#import "MPRuleParticipantView.h"
#import "MPRuleParticipantsPerMatchView.h"
#import "MPRuleWinConditionStatView.h"
#import "MPRuleScoreLimitView.h"
#import "MPRuleStatsView.h"
#import "MPBottomEdgeButton.h"

@implementation MPMakeRuleView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeRuleView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
        [self makeSlides];
        [self setFirstResponder];
    }
    return self;
}

- (void) makeControls {
    //self.form
    self.form = [[MPFormView alloc] init];
    self.form.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.form];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.form
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.form
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           
                           ]];
}

- (void) makeSlides {
    //self.ruleSubviews
    self.form.slideViews = @[[[MPRuleNameView alloc] init], [[MPRuleParticipantView alloc] init],[[MPRuleParticipantsPerMatchView alloc] init], [[MPRuleStatsView alloc] init],
                          [[MPRuleWinConditionStatView alloc] init], [[MPRuleScoreLimitView alloc] init]];
    [self.form addSlideViews];
}

- (void) setFirstResponder {
    MPRuleNameView* nameView = (MPRuleNameView*)[self.form slideWithClass:[MPRuleNameView class]];
    [nameView.nameField becomeFirstResponder];
}

+ (NSString*) defaultSubtitle { return @"New Rule"; }

@end
