//
//  MPSelectMessageRecipientsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/8/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPLabel.h"
#import "MPSelectMessageRecipientsView.h"
#import "MPBottomEdgeButton.h"

@implementation MPSelectMessageRecipientsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPSelectMessageRecipientsView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.instructionLabel
    self.instructionLabel = [[MPLabel alloc] initWithText:@"Select the friends you wish to send a message to, then click \"Select Users\" below."];
    self.instructionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.instructionLabel];
    
    //self.friendsTable
    self.friendsTable = [[UITableView alloc] init];
    self.friendsTable.backgroundColor = [UIColor clearColor];
    self.friendsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.friendsTable.scrollEnabled = YES;
    self.friendsTable.delaysContentTouches = NO;
    self.friendsTable.allowsSelection = YES;
    self.friendsTable.allowsMultipleSelection = YES;
    [self addSubview: self.friendsTable];
    
    //self.goBackButton
    self.goBackButton = [[MPBottomEdgeButton alloc] init];
    [self.goBackButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    self.goBackButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.goBackButton];
    
    //self.selectButton
    self.selectButton = [[MPBottomEdgeButton alloc] init];
    [self.selectButton setTitle:@"SELECT USERS" forState:UIControlStateNormal];
    self.selectButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectButton setBackgroundColor:[UIColor MPDarkGrayColor]];
    [self.selectButton setEnabled:NO];
    [self addSubview:self.selectButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.instructionLabel
                           [NSLayoutConstraint constraintWithItem:self.instructionLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
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
                           //self.friendsTable
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.instructionLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
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
                                                           toItem:self.selectButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-10.0f],
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
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.selectButton
                           [NSLayoutConstraint constraintWithItem:self.selectButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.selectButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.selectButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.selectButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Select Recipients"; }

@end
