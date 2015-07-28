//
//  MPMakeRuleSubviews.m
//  MyPodium
//
//  Created by Connor Neville on 7/22/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIButton+MPImage.h"
#import "UIColor+MPColor.h"

#import "MPMakeRuleSubviews.h"
#import "MPMakeRuleView.h"
#import "MPView.h"
#import "MPLabel.h"
#import "MPTextField.h"
#import "MPRuleButton.h"

@implementation MPMakeRuleSubviews

+ (MPView*) statView {
    MPView* view = [[MPView alloc] init];
    
    MPLabel* titleLabel = [[MPLabel alloc] initWithText:@"STAT TRACKING"];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    titleLabel.tag = 1;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview: titleLabel];
    [view addConstraints:@[//titleLabel
                           [NSLayoutConstraint constraintWithItem:titleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:titleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
    
    MPLabel* infoLabel = [[MPLabel alloc] initWithText:@"You can choose custom stats to record during your MyPodium games. Just enter the names of any stats you want to track, separated by commas. For example, if you're playing Basketball, you could enter \"points, rebounds, assists\"."];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.tag = 2;
    [view addSubview: infoLabel];
    [view addConstraints:@[//infoLabel
                           [NSLayoutConstraint constraintWithItem:infoLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:infoLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:infoLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f]
                           ]];
    
    MPTextField* playerStatsField = [[MPTextField alloc] initWithPlaceholder:@"PLAYER STATS"];
    playerStatsField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    playerStatsField.translatesAutoresizingMaskIntoConstraints = NO;
    playerStatsField.returnKeyType = UIReturnKeyGo;
    playerStatsField.tag = 3;
    [view addSubview: playerStatsField];
    
    [view addConstraints:@[//playerStatsField
                           [NSLayoutConstraint constraintWithItem:playerStatsField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playerStatsField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:playerStatsField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:playerStatsField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]]
                           ]];
    
    MPLabel* teamInfoLabel = [[MPLabel alloc] initWithText:@"Since you selected team participants, you can also track stats on a per-team basis. Enter them below."];
    teamInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    teamInfoLabel.hidden = YES;
    teamInfoLabel.tag = 4;
    [view addSubview: teamInfoLabel];
    [view addConstraints:@[//teamInfoLabel
                           [NSLayoutConstraint constraintWithItem:teamInfoLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:teamInfoLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:teamInfoLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playerStatsField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f]
                           ]];
    
    MPTextField* teamStatsField = [[MPTextField alloc] initWithPlaceholder:@"TEAM STATS"];
    teamStatsField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    teamStatsField.translatesAutoresizingMaskIntoConstraints = NO;
    teamStatsField.returnKeyType = UIReturnKeyGo;
    teamStatsField.hidden = YES;
    teamStatsField.tag = 5;
    [view addSubview: teamStatsField];
    [view addConstraints:@[//teamStatsField
                           [NSLayoutConstraint constraintWithItem:teamStatsField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:teamStatsField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:teamInfoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:teamStatsField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:teamStatsField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]]
                           ]];
    return view;
}

@end
