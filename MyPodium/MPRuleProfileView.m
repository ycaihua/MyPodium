//
//  MPRuleProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 8/5/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPLabel.h"
#import "MPRuleProfileView.h"
#import "MPBottomEdgeButton.h"
#import "MPProfileControlBlock.h"

#import <Parse/Parse.h>

@implementation MPRuleProfileView

- (id) initWithRule: (PFObject*) rule {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:@"Rule Information:"];
    if(self) {
        self.displayedRule = rule;
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
        [self makeControlConstraints];
        [self updateControlsForNewRule];
    }
    return self;
}

- (void) makeControls {
    //self.nameLabel
    self.nameLabel = [[MPLabel alloc] initWithText: ((NSString*)self.displayedRule[@"name"]).uppercaseString];
    self.nameLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.nameLabel];
    
    //self.participantsLabel
    self.participantsLabel = [[MPLabel alloc] initWithText: @"Participants"];
    self.participantsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.participantsLabel];
    
    //self.statsLabel
    self.statsLabel = [[MPLabel alloc] initWithText: @"Stats"];
    self.statsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.statsLabel];
    
    //self.leftBottomButton
    self.bottomButton = [[MPBottomEdgeButton alloc] init];
    [self.bottomButton setTitle:@"GO BACK" forState:UIControlStateNormal];
    self.bottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.bottomButton];
}

- (void) updateControlsForNewRule {
    self.nameLabel.text = [self.displayedRule[@"name"] uppercaseString];
    
    BOOL usesTeams = [self.displayedRule[@"usesTeamParticipants"] boolValue];
    int numParticipants = [self.displayedRule[@"participantsPerMatch"] intValue];
    self.participantsLabel.text = [NSString stringWithFormat:@"Matches are between %d players", numParticipants];
    if(usesTeams) {
        int playersPerTeam = [self.displayedRule[@"playersPerTeam"] intValue];
        self.participantsLabel.text = [NSString stringWithFormat:@"Matches are between %d teams of %d players",
                                       numParticipants, playersPerTeam];
    }
    
    NSArray* playerStats = self.displayedRule[@"playerStats"];
    NSString* playerStatsString = [playerStats componentsJoinedByString:@", "];
    self.statsLabel.text = [NSString stringWithFormat:@"Player stats: %@", playerStatsString];
    if(usesTeams) {
        NSArray* teamStats = self.displayedRule[@"teamStats"];
        NSString* teamStatsString = [teamStats componentsJoinedByString:@", "];
        self.statsLabel.text = [self.statsLabel.text stringByAppendingString:[NSString stringWithFormat:@"\nTeam stats: %@", teamStatsString]];
    }
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.nameLabel
                           [NSLayoutConstraint constraintWithItem:self.nameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.nameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.nameLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           //self.participantsLabel
                           [NSLayoutConstraint constraintWithItem:self.participantsLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.participantsLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.nameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.statsLabel
                           [NSLayoutConstraint constraintWithItem:self.statsLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.statsLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.statsLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.participantsLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.bottomButton
                           [NSLayoutConstraint constraintWithItem:self.bottomButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

@end