//
//  MPTeamProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 8/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTeamRosterView.h"
#import "MPLabel.h"
#import "MPBottomEdgeButton.h"

#import <Parse/Parse.h>

@implementation MPTeamRosterView

- (id) initWithTeam: (PFObject*) team andTeamStatus: (MPTeamStatus) status {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPTeamRosterView defaultSubtitle]];
    if(self) {
        self.team = team;
        self.teamStatus = status;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:[self.team[@"teamName"] uppercaseString]];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.statusLabel
    self.statusLabel = [[MPLabel alloc] init];
    switch (self.teamStatus) {
        case MPTeamStatusOwner:
            self.statusLabel.text = @"You are the owner of this team.";
            break;
        case MPTeamStatusMember:
            self.statusLabel.text = @"You are a member of this team.";
            break;
        case MPTeamStatusInvited:
            self.statusLabel.text = @"You have been invited to join this team.";
            break;
        case MPTeamStatusRequested:
            self.statusLabel.text = @"You have requested to join this team.";
            break;
        case MPTeamStatusNonMember:
            self.statusLabel.text = @"You are not a member of this team.";
        default:
            break;
    }
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.statusLabel];
    
    //self.rosterTable
    self.rosterTable = [[UITableView alloc] init];
    self.rosterTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rosterTable.scrollEnabled = YES;
    self.rosterTable.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.rosterTable];
    
    //self.leftButton
    self.leftButton = [[MPBottomEdgeButton alloc] init];
    [self.leftButton setTitle:@"GO BACK" forState:UIControlStateNormal];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.leftButton];
    
    //self.rightButton
    self.rightButton = [[MPBottomEdgeButton alloc] init];
    switch (self.teamStatus) {
        case MPTeamStatusOwner:
            [self.rightButton setTitle:@"OWNER SETTINGS" forState:UIControlStateNormal];
            break;
        case MPTeamStatusMember:
            [self.rightButton setTitle:@"LEAVE TEAM" forState:UIControlStateNormal];
            break;
        case MPTeamStatusInvited:
            [self.rightButton setTitle:@"ACCEPT/DENY" forState:UIControlStateNormal];
            break;
        case MPTeamStatusRequested:
            [self.rightButton setTitle:@"CANCEL REQUEST" forState:UIControlStateNormal];
            break;
        case MPTeamStatusNonMember:
            [self.rightButton setTitle:@"REQUEST TO JOIN" forState:UIControlStateNormal];
            break;
    }
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.rightButton];
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
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           //self.statusLabel
                           [NSLayoutConstraint constraintWithItem:self.statusLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.statusLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.statusLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.rosterTable
                           [NSLayoutConstraint constraintWithItem:self.rosterTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rosterTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rosterTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.statusLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.rosterTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           //self.leftButton
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.rightButton
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Team Roster"; }

@end
