//
//  MPRuleStatsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPRuleStatsView.h"
#import "MPLabel.h"
#import "MPTextField.h"

@implementation MPRuleStatsView

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
    self.titleLabel = [[MPLabel alloc] initWithText:@"STAT TRACKING"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:@"You can choose custom stats to record during your MyPodium games by entering them below, separated by commas. For example, if you're playing Basketball, you could enter \"points, rebounds, assists\"."];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];

    //self.playerStatsField
    self.playerStatsField = [[MPTextField alloc] initWithPlaceholder:@"PLAYER STATS"];
    self.playerStatsField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.playerStatsField.translatesAutoresizingMaskIntoConstraints = NO;
    self.playerStatsField.returnKeyType = UIReturnKeyGo;
    self.playerStatsField.clearButtonMode = UITextFieldViewModeNever;
    [self addSubview: self.playerStatsField];
    
    //self.teamInfoLabel
    self.teamInfoLabel = [[MPLabel alloc] initWithText:@"Since you selected team participants, you can also track stats on a per-team basis. Enter them below."];
    self.teamInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.teamInfoLabel.hidden = YES;
    [self addSubview: self.teamInfoLabel];
    
    //self.teamStatsField
    self.teamStatsField = [[MPTextField alloc] initWithPlaceholder:@"TEAM STATS"];
    self.teamStatsField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.teamStatsField.returnKeyType = UIReturnKeyGo;
    self.teamStatsField.clearButtonMode = UITextFieldViewModeNever;
    self.teamStatsField.hidden = YES;
    self.teamStatsField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.teamStatsField];
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
                           //self.playerStatsField
                           [NSLayoutConstraint constraintWithItem:self.playerStatsField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playerStatsField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.playerStatsField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.playerStatsField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.teamInfoLabel
                           [NSLayoutConstraint constraintWithItem:self.teamInfoLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamInfoLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamInfoLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.playerStatsField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.teamStatsLabel
                           [NSLayoutConstraint constraintWithItem:self.teamStatsField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamStatsField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.teamInfoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamStatsField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.teamStatsField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]]
                           ]];

}

- (void) adjustForKeyboardShowing: (BOOL) keyboardShowing {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.teamInfoLabel] &&
           constraint.firstAttribute == NSLayoutAttributeTop) {
            [self removeConstraint: constraint];
            break;
        }
    }
    if(keyboardShowing) {
        for(UIView* view in @[self.infoLabel, self.playerStatsField]) {
                view.hidden = YES;
        }
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.teamInfoLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.titleLabel
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                       constant:5.0f]];
    }
    else {
        [self addConstraint:
         [NSLayoutConstraint constraintWithItem:self.teamInfoLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.playerStatsField
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0f
                                       constant:5.0f]];
        
    }
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(!keyboardShowing){
            for(UIView* view in @[self.infoLabel, self.playerStatsField]) {
                view.hidden = NO;
            }
        }
    }];
}

@end
