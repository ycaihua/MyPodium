//
//  MPTeamInviteUsersView.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPTeamInviteUsersView.h"
#import "MPLabel.h"
#import "MPBottomEdgeButton.h"

#import <Parse/Parse.h>

@implementation MPTeamInviteUsersView

- (id) initWithTeam:(PFObject *)team withRemainingSpots: (NSInteger) remainingSpots {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPTeamInviteUsersView defaultSubtitle]];
    if(self) {
        self.team = team;
        self.remainingSpots = remainingSpots;
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.infoLabel
    self.infoLabel = [[MPLabel alloc] initWithText:[NSString stringWithFormat:@"Select users to invite to your team, %@. You have room on your team to send up to %ld invitations.", self.team[@"name"], (long)self.remainingSpots]];
    self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.infoLabel];
    
    //self.friendsTable
    self.friendsTable = [[UITableView alloc] init];
    self.friendsTable.backgroundColor = [UIColor clearColor];
    self.friendsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.friendsTable.scrollEnabled = YES;
    self.friendsTable.allowsSelection = YES;
    self.friendsTable.allowsMultipleSelection = YES;
    [self addSubview: self.friendsTable];

    //self.leftButton
    self.leftButton = [[MPBottomEdgeButton alloc] init];
    [self.leftButton setTitle:@"GO BACK" forState:UIControlStateNormal];
    self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.leftButton];
    
    //self.rightButton
    self.rightButton = [[MPBottomEdgeButton alloc] init];
    [self.rightButton setTitle:@"INVITE USERS" forState:UIControlStateNormal];
    [self.rightButton disable];
    self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.rightButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.infoLabel
                           [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
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
                           //self.friendsTable
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.infoLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.leftButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           //self.leftButton
                           [NSLayoutConstraint constraintWithItem:self.leftButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
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
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.rightButton
                           [NSLayoutConstraint constraintWithItem:self.rightButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
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
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

- (void) updateForRemainingSpots {
    self.infoLabel.text = [NSString stringWithFormat:@"Select users to invite to your team, %@. You have room on your team to send up to %ld invitations.", self.team[@"name"], (long)self.remainingSpots];
}

+ (NSString*) defaultSubtitle { return @"Invite Users"; }

@end
