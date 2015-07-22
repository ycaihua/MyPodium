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
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
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
    
    MPLabel* titleLabel = [[MPLabel alloc] initWithText:@"PARTICIPANTS"];
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
    
    MPLabel* infoLabel = [[MPLabel alloc] initWithText:@"Choose whether you want matches to be played between teams or between individual players (these are called your \"participants\")."];
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
    
    UISwitch* teamParticipantsSwitch = [[UISwitch alloc] init];
    teamParticipantsSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    teamParticipantsSwitch.tag = 1;
    [teamParticipantsSwitch addTarget: self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview: teamParticipantsSwitch];
    
    [view addConstraints:@[//teamParticipantsSwitch
                           [NSLayoutConstraint constraintWithItem:teamParticipantsSwitch
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:teamParticipantsSwitch
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f]
                           ]];
    
    MPLabel* switchLabel = [[MPLabel alloc] initWithText:@"Toggle using teams as participants"];
    switchLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview: switchLabel];
    
    [view addConstraints:@[//switchLabel
                           [NSLayoutConstraint constraintWithItem:switchLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:switchLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:teamParticipantsSwitch
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           [NSLayoutConstraint constraintWithItem:switchLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:teamParticipantsSwitch
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
    
    MPLabel* playersPerTeamTitle = [[MPLabel alloc] initWithText:@"PLAYERS PER TEAM"];
    playersPerTeamTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    playersPerTeamTitle.translatesAutoresizingMaskIntoConstraints = NO;
    playersPerTeamTitle.hidden = YES;
    playersPerTeamTitle.tag = 2;
    [view addSubview: playersPerTeamTitle];
    [view addConstraints:@[//playersPerTeamTitle
                           [NSLayoutConstraint constraintWithItem:playersPerTeamTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:teamParticipantsSwitch
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f]
                           ]];
    
    MPLabel* playersPerTeamLabel = [[MPLabel alloc] initWithText:@"Since you have teams selected, you need to enter how many players per team can play."];
    playersPerTeamLabel.tag = 3;
    playersPerTeamLabel.hidden = YES;
    playersPerTeamLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview: playersPerTeamLabel];
    [view addConstraints:@[//playersPerTeamLabel
                           [NSLayoutConstraint constraintWithItem:playersPerTeamLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f]
                           ]];
    
    MPTextField* playersPerTeamField = [[MPTextField alloc] initWithPlaceholder:@"PLAYERS PER TEAM"];
    playersPerTeamField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    playersPerTeamField.translatesAutoresizingMaskIntoConstraints = NO;
    playersPerTeamField.tag = 4;
    playersPerTeamField.hidden = YES;
    [view addSubview: playersPerTeamField];
    
    [view addConstraints:@[//playersPerTeamField
                           [NSLayoutConstraint constraintWithItem:playersPerTeamField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]]
                           ]];
    
    
    return view;
}

+ (void) switchStateChanged: (id) sender {
    UISwitch* switchSender = (UISwitch*) sender;
    BOOL state = [switchSender isOn];
    UIView* superview = switchSender.superview;
    //Tags used: 2, 3, 4
    for(int i = 2; i < 5; i++) {
        [superview viewWithTag:i].hidden = !state;
    }
}
@end
