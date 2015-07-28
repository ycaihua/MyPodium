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

+ (MPView*) introAndNamingView {
    MPView* view = [[MPView alloc] init];
    
    [view addConstraints:@[//nameField
                           
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
    
    MPLabel* infoLabel = [[MPLabel alloc] initWithText:@"Choose whether games played with these rules should be player versus player or team versus team. (In other words, are players the participants in your games, or teams?)"];
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
    
    MPRuleButton* participantsButton = [[MPRuleButton alloc] init];
    participantsButton.translatesAutoresizingMaskIntoConstraints = NO;
    participantsButton.tag = 1;
    [view addSubview: participantsButton];
    [view addConstraints:@[//playersPerTeamTitle
                           [NSLayoutConstraint constraintWithItem:participantsButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:participantsButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:participantsButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:participantsButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPRuleButton defaultHeight]]
                           ]];
    [participantsButton addTarget:self action:@selector(participantsChanged:) forControlEvents:UIControlEventTouchUpInside];
    
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
                                                           toItem:participantsButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f]
                           ]];
    
    MPLabel* playersPerTeamLabel = [[MPLabel alloc] initWithText:@"Since you have team participants selected, you need to enter how many players per team can play."];
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
    
    MPLabel* playersPerTeamCounter = [[MPLabel alloc] initWithText:@"2"];
    playersPerTeamCounter.textColor = [UIColor whiteColor];
    playersPerTeamCounter.textAlignment = NSTextAlignmentCenter;
    playersPerTeamCounter.backgroundColor = [UIColor MPBlackColor];
    playersPerTeamCounter.font = [UIFont fontWithName:@"Oswald-Bold" size:32.0f];
    playersPerTeamCounter.tag = 4;
    playersPerTeamCounter.hidden = YES;
    playersPerTeamCounter.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview: playersPerTeamCounter];
    [view addConstraints:@[//playersPerTeamCounter
                           [NSLayoutConstraint constraintWithItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:view
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.25f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           ]];
    
    
    UIButton* decrementButton = [[UIButton alloc] init];
    [decrementButton setImageString:@"minus" withColorString:@"black" withHighlightedColorString:@"black"];
    decrementButton.tag = 5;
    decrementButton.hidden = YES;
    decrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview: decrementButton];
    [view addConstraints:@[//decrementButton
                           [NSLayoutConstraint constraintWithItem:decrementButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:decrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:decrementButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           [NSLayoutConstraint constraintWithItem:decrementButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           ]];
    
    UIButton* incrementButton = [[UIButton alloc] init];
    [incrementButton setImageString:@"plus" withColorString:@"black" withHighlightedColorString:@"black"];
    incrementButton.tag = 6;
    incrementButton.hidden = YES;
    incrementButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview: incrementButton];
    [view addConstraints:@[//incrementButton
                           [NSLayoutConstraint constraintWithItem:incrementButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:incrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:playersPerTeamCounter
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:incrementButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           [NSLayoutConstraint constraintWithItem:incrementButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[UIButton standardWidthAndHeight]],
                           ]];
    
    return view;
}

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

+ (void) participantsChanged: (id) sender {
    MPRuleButton* buttonSender = (MPRuleButton*) sender;
    [buttonSender toggleSelected];
    BOOL playerParticipantState = [buttonSender playerModeSelected];
    MPView* superview = (MPView*)buttonSender.superview;
    //Tags to hide: 2, 3, 4, 5, 6
    for(int i = 2; i < 7; i++) {
        [superview viewWithTag:i].hidden = playerParticipantState;
    }
    
    //Update next view
    MPMakeRuleView* mainView = (MPMakeRuleView*)superview.superview;
    MPView* statsView = mainView.ruleSubviews[mainView.subviewIndex + 1];
    //Tags to hide: 4, 5
    for(int i = 4; i < 6; i++) {
        [statsView viewWithTag:i].hidden = playerParticipantState;
    }
    MPTextField* playerStatsField = (MPTextField*)[statsView viewWithTag:3];
    if(playerParticipantState) {
        playerStatsField.returnKeyType = UIReturnKeyGo;
    }
    else {
        playerStatsField.returnKeyType = UIReturnKeyNext;
    }
}
@end
