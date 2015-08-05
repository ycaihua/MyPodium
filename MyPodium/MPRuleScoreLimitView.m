//
//  MPRuleScoreLimitView.m
//  MyPodium
//
//  Created by Connor Neville on 7/29/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"
#import "UIButton+MPImage.h"
#import "UIColor+MPColor.h"

#import "MPRuleScoreLimitView.h"
#import "MPLabel.h"
#import "MPRuleButton.h"

@implementation MPRuleScoreLimitView

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
    self.titleLabel = [[MPLabel alloc] initWithText:@"SCORE LIMIT"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:@"A participant will win when their stat reaches:"];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];
    
    //self.winConditionCounter
    self.winConditionCounter = [[MPLabel alloc] initWithText:@"10"];
    self.winConditionCounter.textColor = [UIColor whiteColor];
    self.winConditionCounter.textAlignment = NSTextAlignmentCenter;
    self.winConditionCounter.backgroundColor = [UIColor MPBlackColor];
    self.winConditionCounter.font = [UIFont fontWithName:@"Oswald-Bold" size:32.0f];
    self.winConditionCounter.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.winConditionCounter];
    
    //self.decrementButton
    self.decrementButton = [[UIButton alloc] init];
    [self.decrementButton setImageString:@"minus" withColorString:@"black" withHighlightedColorString:@"black"];
    self.decrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.decrementButton addTarget:self action:@selector(decrementButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.decrementButton];
    
    //self.incrementButton
    self.incrementButton = [[UIButton alloc] init];
    [self.incrementButton setImageString:@"plus" withColorString:@"black" withHighlightedColorString:@"black"];
    self.incrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.incrementButton addTarget:self action:@selector(incrementButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.incrementButton];
    
    //self.noLimitLabel
    self.noLimitLabel = [[MPLabel alloc] initWithText:@"Or, instead, press this button if your games have no score limit (for example, if they use a timer instead)."];
    self.noLimitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.noLimitLabel];
    
    //self.scoreLimitButton
    self.scoreLimitButton = [[MPRuleButton alloc] initWithToggledOnTitle:@"SCORE LIMIT ENABLED" onSubtitle:@"tap to disable" offTitle:@"SCORE LIMIT DISABLED" offSubtitle:@"tap to enable"];
    self.scoreLimitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.scoreLimitButton];
}

- (void) updateWithStatName:(NSString *)statName {
    self.infoLabel.text = [NSString stringWithFormat:@"A participant will win when their \"%@\" stat reaches:", statName];
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
                           //self.winConditionCounter
                           [NSLayoutConstraint constraintWithItem:self.winConditionCounter
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.winConditionCounter
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.winConditionCounter
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.25f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.winConditionCounter
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
                                                           toItem:self.winConditionCounter
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.winConditionCounter
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
                                                           toItem:self.winConditionCounter
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.winConditionCounter
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
                                                         constant:[UIButton standardWidthAndHeight]],
                           //self.noLimitLabel
                           [NSLayoutConstraint constraintWithItem:self.noLimitLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.noLimitLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.noLimitLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.winConditionCounter
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           //self.scoreLimitButton
                           [NSLayoutConstraint constraintWithItem:self.scoreLimitButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.decrementButton
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.scoreLimitButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.incrementButton
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.scoreLimitButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.noLimitLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.scoreLimitButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPRuleButton defaultHeight]],
                           ]];
    
}

- (void) decrementButtonPressed: (id) sender {
    [self.winConditionCounter decrementTextAndRevertAfter:NO withBound:1];
}

- (void) incrementButtonPressed: (id) sender {
    [self.winConditionCounter incrementTextAndRevertAfter:NO withBound:100];
}

@end