//
//  MPMakeGameModeSubviews.m
//  MyPodium
//
//  Created by Connor Neville on 7/22/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMakeGameModeSubviews.h"
#import "MPView.h"
#import "MPLabel.h"
#import "MPTextField.h"

@implementation MPMakeGameModeSubviews

+ (MPView*) introAndNamingView {
    MPView* view = [[MPView alloc] init];
    
    MPLabel* titleLabel = [[MPLabel alloc] initWithText:@"GAME MODE CREATION"];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
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
    
    MPLabel* infoLabel = [[MPLabel alloc] initWithText:@"Game modes are a critical part of creating a MyPodium event. In your game mode, you can tell us which stats you want to track and how you want your game to be played. Start by entering a name for your game mode below."];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
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
    
    MPTextField* usernameField = [[MPTextField alloc] initWithPlaceholder:@"GAME MODE NAME"];
    usernameField.translatesAutoresizingMaskIntoConstraints = NO;
    usernameField.tag = 1;
    [view addSubview: usernameField];
    
    [view addConstraints:@[//usernameField
                           [NSLayoutConstraint constraintWithItem:usernameField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:usernameField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:usernameField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:usernameField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]]
                           ]];
    return view;
}

+ (MPView*) participantTypeView {
    MPView* view = [[MPView alloc] init];
    
    return view;
}
@end
