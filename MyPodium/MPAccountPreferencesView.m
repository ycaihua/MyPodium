//
//  MPAccountPreferencesView.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPLabel.h"
#import "MPPreferencesButton.h"
#import "MPAccountPreferencesView.h"

@implementation MPAccountPreferencesView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPAccountPreferencesView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.friendRequestsTitle
    self.friendRequestsTitle = [[MPLabel alloc] initWithText:@"FRIEND REQUESTS"];
    self.friendRequestsTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:22.0f];
    self.friendRequestsTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.friendRequestsTitle];
    
    //self.friendRequestsDescription
    self.friendRequestsDescription = [[MPLabel alloc] initWithText:@"Use the below button to toggle whether you want other users to be able to send you friend requests. If turned off, you can still send other users friend requests."];
    self.friendRequestsDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.friendRequestsDescription];
    
    //self.friendRequestsView
    self.friendRequestsView = [[UIView alloc] init];
    self.friendRequestsView.backgroundColor = [UIColor MPBlackColor];
    self.friendRequestsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.friendRequestsView];
    
    //self.friendRequestsImage
    self.friendRequestsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_black.png"]];
    self.friendRequestsImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendRequestsImage.contentMode = UIViewContentModeCenter;
    [self.friendRequestsView addSubview: self.friendRequestsImage];
    
    //self.friendRequestsButton
    self.friendRequestsButton = [[MPPreferencesButton alloc] init];
    self.friendRequestsButton.referenceImage = self.friendRequestsImage;
    [self.friendRequestsView addSubview: self.friendRequestsButton];
    
    
    //self.confirmationAlertsTitle
    self.confirmationAlertsTitle = [[MPLabel alloc] initWithText:@"CONFIRMATION ALERTS"];
    self.confirmationAlertsTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:22.0f];
    self.confirmationAlertsTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmationAlertsTitle];
    
    //self.friendRequestsDescription
    self.confirmationAlertsDescription = [[MPLabel alloc] initWithText:@"By default, you are asked for confirmation before doing things like removing friends, denying team invites or leaving a team. You can toggle whether or not these dialogues appear below."];
    self.confirmationAlertsDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmationAlertsDescription];
    
    //self.confirmationAlertsView
    self.confirmationAlertsView = [[UIView alloc] init];
    self.confirmationAlertsView.backgroundColor = [UIColor MPBlackColor];
    self.confirmationAlertsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmationAlertsView];
    
    //self.confirmationAlertsImage
    self.confirmationAlertsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_black.png"]];
    self.confirmationAlertsImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmationAlertsImage.contentMode = UIViewContentModeCenter;
    [self.confirmationAlertsView addSubview: self.confirmationAlertsImage];
    
    //self.confirmationAlertsButton
    self.confirmationAlertsButton = [[MPPreferencesButton alloc] init];
    self.confirmationAlertsButton.referenceImage = self.confirmationAlertsImage;
    [self.confirmationAlertsView addSubview: self.confirmationAlertsButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.friendRequestsTitle
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsTitle
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.friendRequestsDescription
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsDescription
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsDescription
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsDescription
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.friendRequestsView
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsDescription
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:-10.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           //self.friendRequestsImage
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsImage
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsImage
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsImage
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsImage
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           //self.friendRequestsButton
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsImage
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.confirmationAlertsTitle
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.friendRequestsView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsTitle
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.confirmationAlertsDescription
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsDescription
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsDescription
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsDescription
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.confirmationAlertsView
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsDescription
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:-10.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           //self.confirmationAlertsImage
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsImage
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsImage
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsImage
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsImage
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           //self.confirmationAlertsButton
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsImage
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmationAlertsButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Account Preferences"; }

@end
