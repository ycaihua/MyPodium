//
//  MPMakeTeamView.m
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPMakeTeamView.h"
#import "MPTextField.h"
#import "MPLabel.h"
#import "MPTeamsButton.h"

@implementation MPMakeTeamView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeTeamView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.teamNameField
    self.teamNameField = [[MPTextField alloc] initWithPlaceholder:@"TEAM NAME"];
    self.teamNameField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.teamNameField];
    
    //self.instructionLabel
    self.instructionLabel = [[MPLabel alloc] initWithText:@"Enter your desired team name above, and select any friends you wish to add to the team below. Then click submit, and your team will be ready to go."];
    self.instructionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.instructionLabel];
    
    //self.playersTable
    self.playersTable = [[UITableView alloc] init];
    self.playersTable.backgroundColor = [UIColor clearColor];
    self.playersTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.playersTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.playersTable.scrollEnabled = YES;
    self.playersTable.delaysContentTouches = NO;
    [self addSubview: self.playersTable];
    
    //self.submitButton
    self.submitButton = [[MPTeamsButton alloc] init];
    [self.submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    self.submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.submitButton setBackgroundColor:[UIColor MPDarkGrayColor]];
    [self.submitButton setEnabled:NO];
    [self addSubview:self.submitButton];
    
    //self.goBackButton
    self.goBackButton = [[MPTeamsButton alloc] init];
    [self.goBackButton setTitle:@"GO BACK" forState:UIControlStateNormal];
    self.goBackButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.goBackButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.teamNameField
                           [NSLayoutConstraint constraintWithItem:self.teamNameField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamNameField
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamNameField
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamNameField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.instructionLabel
                           [NSLayoutConstraint constraintWithItem:self.instructionLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.teamNameField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.instructionLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.instructionLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.playersTable
                           [NSLayoutConstraint constraintWithItem:self.playersTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.instructionLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.playersTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.submitButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           //self.submitButton
                           [NSLayoutConstraint constraintWithItem:self.submitButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.submitButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.submitButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.submitButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTeamsButton defaultHeight]],
                           //self.goBackButton
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTeamsButton defaultHeight]]
                           ]];
}

+ (NSString*) defaultSubtitle { return @"New Team"; }

@end
