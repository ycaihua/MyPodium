//
//  MPRuleParticipantsPerMatchView.m
//  MyPodium
//
//  Created by Connor Neville on 7/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"
#import "UIButton+MPImage.h"
#import "UIColor+MPColor.h"

#import "MPRuleParticipantsPerMatchView.h"
#import "MPLabel.h"

@implementation MPRuleParticipantsPerMatchView

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
    self.titleLabel = [[MPLabel alloc] initWithText:@"PARTICIPANTS PER MATCH"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:@"How many parties are involved in each match? If your matches are head-to-head, keep this at 2. If more than two parties can be involved, like in a swimming match or a race, choose an appropriate number."];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];
    
    //self.participantsPerMatchCounter
    self.participantsPerMatchCounter = [[MPLabel alloc] initWithText:@"2"];
    self.participantsPerMatchCounter.textColor = [UIColor whiteColor];
    self.participantsPerMatchCounter.textAlignment = NSTextAlignmentCenter;
    self.participantsPerMatchCounter.backgroundColor = [UIColor MPBlackColor];
    self.participantsPerMatchCounter.font = [UIFont fontWithName:@"Oswald-Bold" size:32.0f];
    self.participantsPerMatchCounter.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.participantsPerMatchCounter];
    
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
                                                        attribute:NSLayoutAttributeTopMargin
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
                           //self.participantsPerMatchCounter
                           [NSLayoutConstraint constraintWithItem:self.participantsPerMatchCounter
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsPerMatchCounter
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsPerMatchCounter
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.25f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsPerMatchCounter
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
                                                           toItem:self.participantsPerMatchCounter
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.participantsPerMatchCounter
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
                                                           toItem:self.participantsPerMatchCounter
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.participantsPerMatchCounter
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

- (void) decrementButtonPressed: (id) sender {
    [self.participantsPerMatchCounter decrementTextAndRevertAfter:NO withBound:2];
}

- (void) incrementButtonPressed: (id) sender {
    [self.participantsPerMatchCounter incrementTextAndRevertAfter:NO withBound:[MPLimitConstants maxParticipantsPerMatch]];
}

@end
