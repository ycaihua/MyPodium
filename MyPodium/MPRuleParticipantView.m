//
//  MPRuleParticipantView.m
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPRuleParticipantView.h"
#import "MPRuleStatsView.h"
#import "MPLabel.h"
#import "MPRuleButton.h"
#import "MPMakeRuleView.h"
#import "MPTextField.h"

@implementation MPRuleParticipantView

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
    self.titleLabel = [[MPLabel alloc] initWithText:@"PARTICIPANTS"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:@"Choose whether games played with these rules should be player-versus-player games, or team-versus-team games."];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];
    
    //self.participantsButton
    self.participantsButton = [[MPRuleButton alloc] init];
    self.participantsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.participantsButton addTarget:self action:@selector(participantsChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.participantsButton];
    
    //self.playersPerTeamTitle
    self.playersPerTeamTitle = [[MPLabel alloc] initWithText:@"PLAYERS PER TEAM"];
    self.playersPerTeamTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.playersPerTeamTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.playersPerTeamTitle.hidden = YES;
    [self addSubview: self.playersPerTeamTitle];

    //self.playersPerTeamLabel
    self.playersPerTeamLabel = [[MPLabel alloc] initWithText:@"Since you have team participants selected, you need to enter how many players per team can play."];
    self.playersPerTeamLabel.hidden = YES;
    self.playersPerTeamLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.playersPerTeamLabel];
    
    //self.playersPerTeamCounter
    self.playersPerTeamCounter = [[MPLabel alloc] initWithText:@"2"];
    self.playersPerTeamCounter.textColor = [UIColor whiteColor];
    self.playersPerTeamCounter.textAlignment = NSTextAlignmentCenter;
    self.playersPerTeamCounter.backgroundColor = [UIColor MPBlackColor];
    self.playersPerTeamCounter.font = [UIFont fontWithName:@"Oswald-Bold" size:32.0f];
    self.playersPerTeamCounter.hidden = YES;
    self.playersPerTeamCounter.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.playersPerTeamCounter];
    
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
                           //self.participantsButton
                           [NSLayoutConstraint constraintWithItem:self.participantsButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPRuleButton defaultHeight]],
                           //self.playersPerTeamTitle
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.participantsButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.playersPerTeamLabel
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.playersPerTeamTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.playersPerTeamCounter
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamCounter
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamCounter
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.playersPerTeamLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamCounter
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.25f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersPerTeamCounter
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
                                                           toItem:self.playersPerTeamCounter
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.decrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.playersPerTeamCounter
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
                                                           toItem:self.playersPerTeamCounter
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.incrementButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.playersPerTeamCounter
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

- (void) participantsChanged: (id) sender {
    MPRuleButton* buttonSender = (MPRuleButton*) sender;
    [buttonSender toggleSelected];
    BOOL playerParticipantState = [buttonSender playerModeSelected];
    //Hide and show views based on toggle selected
    for(UIView* subview in @[self.playersPerTeamTitle, self.playersPerTeamLabel, self.playersPerTeamCounter, self.incrementButton, self.decrementButton]) {
        subview.hidden = playerParticipantState;
    }
    
    //Update stats view same way - stats view is 2 subviews down in rotation
    MPMakeRuleView* mainView = (MPMakeRuleView*)self.superview;
    MPRuleStatsView* statsView = mainView.ruleSubviews[mainView.subviewIndex + 2];
    for(UIView* subview in @[statsView.teamInfoLabel, statsView.teamStatsField]) {
        subview.hidden = playerParticipantState;
    }
    MPTextField* playerStatsField = statsView.playerStatsField;
    if(playerParticipantState) {
        playerStatsField.returnKeyType = UIReturnKeyGo;
    }
    else {
        playerStatsField.returnKeyType = UIReturnKeyNext;
    }
}

- (void) decrementButtonPressed: (id) sender {
    [self.playersPerTeamCounter decrementTextAndRevertAfter:NO withBound:2];
}

- (void) incrementButtonPressed: (id) sender {
    [self.playersPerTeamCounter incrementTextAndRevertAfter:NO withBound:[MPLimitConstants maxPlayersPerTeam]];
}

@end
