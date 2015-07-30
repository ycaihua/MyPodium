//
//  MPRuleTimerView.m
//  MyPodium
//
//  Created by Connor Neville on 7/29/15.
//  Copyright © 2015 connorneville. All rights reserved.
//
#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPRuleTimerView.h"
#import "MPRuleStatsView.h"
#import "MPLabel.h"
#import "MPRuleButton.h"
#import "MPMakeRuleView.h"
#import "MPTextField.h"

@implementation MPRuleTimerView

- (id) init {
    self = [super init];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"TIMER"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:@"Choose whether you want a timer to appear in your matches for you to manage."];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];
    
    //self.timerButton
    self.timerButton = [[MPRuleButton alloc] initWithToggledOnTitle:@"TIMER DISABLED" onSubtitle:@"tap to toggle timer on" offTitle:@"TIMER ENABLED" offSubtitle:@"tap to toggle timer off"];
    self.timerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.timerButton addTarget:self action:@selector(timerSettingChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.timerButton];
    
    //self.timerDurationTitle
    self.timerDurationTitle = [[MPLabel alloc] initWithText:@"DEFAULT TIMER DURATION"];
    self.timerDurationTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.timerDurationTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.timerDurationTitle.hidden = YES;
    [self addSubview: self.timerDurationTitle];
    
    //self.timerDurationLabel
    self.timerDurationLabel = [[MPLabel alloc] initWithText:@"You can always change or reset your timer during matches, but choose a default time (in minutes) below."];
    self.timerDurationLabel.hidden = YES;
    self.timerDurationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.timerDurationLabel];
    
    //self.timerDurationCounter
    self.timerDurationCounter = [[MPLabel alloc] initWithText:@"5"];
    self.timerDurationCounter.textColor = [UIColor whiteColor];
    self.timerDurationCounter.textAlignment = NSTextAlignmentCenter;
    self.timerDurationCounter.backgroundColor = [UIColor MPBlackColor];
    self.timerDurationCounter.font = [UIFont fontWithName:@"Oswald-Bold" size:32.0f];
    self.timerDurationCounter.hidden = YES;
    self.timerDurationCounter.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.timerDurationCounter];
    
    //self.decrementButton
    self.decrementButton = [[UIButton alloc] init];
    [self.decrementButton setImageString:@"minus" withColorString:@"black" withHighlightedColorString:@"black"];
    self.decrementButton.hidden = YES;
    [self.decrementButton addTarget:self action:@selector(decrementButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.decrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.decrementButton];
    
    //self.incrementButton
    self.incrementButton = [[UIButton alloc] init];
    [self.incrementButton setImageString:@"plus" withColorString:@"black" withHighlightedColorString:@"black"];
    self.incrementButton.hidden = YES;
    [self.incrementButton addTarget:self action:@selector(incrementButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.incrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.incrementButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.titleLabel
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.infoLabel
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.timerButton
                           [NSLayoutConstraint constraintWithItem:self.timerButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPRuleButton defaultHeight]],
                           //self.timerDurationTitle
                           [NSLayoutConstraint constraintWithItem:self.timerDurationTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerDurationTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.timerDurationLabel
                           [NSLayoutConstraint constraintWithItem:self.timerDurationLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerDurationLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerDurationLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerDurationTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.timerDurationCounter
                           [NSLayoutConstraint constraintWithItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerDurationLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.25f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           //self.decrementButton
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           //self.incrementButton
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.timerDurationCounter
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]]
                           ]];
    
}

- (void) timerSettingChanged: (id) sender {
    MPRuleButton* buttonSender = (MPRuleButton*) sender;
    [buttonSender toggleSelected];
    BOOL usesTimer = ![buttonSender toggledOn];
    //Hide and show views based on toggle selected
    for(UIView* subview in @[self.timerDurationTitle, self.timerDurationLabel, self.timerDurationCounter, self.incrementButton, self.decrementButton]) {
        subview.hidden = !usesTimer;
    }
}

- (void) decrementButtonPressed: (id) sender {
    [self.timerDurationCounter decrementTextAndRevertAfter:NO withBound:2];
}

- (void) incrementButtonPressed: (id) sender {
    [self.timerDurationCounter incrementTextAndRevertAfter:NO withBound:[MPLimitConstants maxPlayersPerTeam]];
}

@end
