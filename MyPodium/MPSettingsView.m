//
//  MPSettingsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPLabel.h"
#import "MPView.h"
#import "MPMenu.h"
#import "MPPreferencesButton.h"
#import "MPSettingsView.h"
#import "MPTextField.h"
#import "MPSettingsScrollView.h"

@implementation MPSettingsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPSettingsView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
        self.preferencesScrollView.contentSize = [MPSettingsView scrollingBounds];
    }
    return self;
}

- (void) makeControls {
    //self.preferencesScrollView
    self.preferencesScrollView = [[MPSettingsScrollView alloc] init];
    self.preferencesScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.preferencesScrollView.userInteractionEnabled = YES;
    self.preferencesScrollView.canCancelContentTouches = NO;
    [self addSubview:self.preferencesScrollView];
    
    //self.preferencesContentView
    self.preferencesContentView = [[MPView alloc] init];
    self.preferencesContentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.preferencesContentView.userInteractionEnabled = YES;
    [self.preferencesScrollView addSubview: self.preferencesContentView];
    
    //self.realNameTitle
    self.realNameTitle = [[MPLabel alloc] initWithText:@"REAL/DISPLAY NAME"];
    self.realNameTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:22.0f];
    self.realNameTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.preferencesContentView addSubview: self.realNameTitle];
    
    //self.realNameLabel
    self.realNameLabel = [[MPLabel alloc] initWithText:@"You can optionally enter your real name here so your friends can identify you."];
    self.realNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.realNameLabel];
    
    //self.realNameField
    self.realNameField = [[MPTextField alloc] initWithPlaceholder:@"REAL NAME"];
    self.realNameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.realNameField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.realNameField];
    
    //self.submitNameButton
    self.submitNameButton = [[UIButton alloc] init];
    self.submitNameButton.backgroundColor = [UIColor MPBlackColor];
    [self.submitNameButton setTitle:@"SAVE NAME" forState:UIControlStateNormal];
    [self.submitNameButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.submitNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.submitNameButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.submitNameButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.submitNameButton];
    
    //self.changePasswordTitle
    self.changePasswordTitle = [[MPLabel alloc] initWithText:@"CHANGE PASSWORD"];
    self.changePasswordTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:22.0f];
    self.changePasswordTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.changePasswordTitle];
    
    //self.changePasswordLabel
    self.changePasswordLabel = [[MPLabel alloc] initWithText:@"If you want to change the password for your account, enter a new one below."];
    self.changePasswordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.changePasswordLabel];
    
    //self.changePasswordField
    self.changePasswordField = [[MPTextField alloc] initWithPlaceholder:@"CHANGE PASSWORD"];
    self.changePasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.changePasswordField];
    
    //self.confirmPasswordLabel
    self.confirmPasswordLabel = [[MPLabel alloc] initWithText:@"Confirm your new password by re-entering it."];
    self.confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmPasswordLabel];
    
    //self.confirmPasswordField
    self.confirmPasswordField = [[MPTextField alloc] initWithPlaceholder:@"CONFIRM PASSWORD"];
    self.confirmPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmPasswordField];
    
    //self.oldPasswordLabel
    self.oldPasswordLabel = [[MPLabel alloc] initWithText:@"In order to change your password, you must enter your currently used password below."];
    self.oldPasswordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.oldPasswordLabel];
    
    //self.oldPasswordField
    self.oldPasswordField = [[MPTextField alloc] initWithPlaceholder:@"OLD PASSWORD"];
    self.oldPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.oldPasswordField];
    
    //self.submitPasswordButton
    self.submitPasswordButton = [[UIButton alloc] init];
    self.submitPasswordButton.backgroundColor = [UIColor MPBlackColor];
    [self.submitPasswordButton setTitle:@"SAVE PASSWORD" forState:UIControlStateNormal];
    [self.submitPasswordButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.submitPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.submitPasswordButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.submitPasswordButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.submitPasswordButton];
    
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
    
    //self.confirmationAlertsDescription
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
    
    //self.emailVerifiedTitle
    self.emailVerifiedTitle = [[MPLabel alloc] initWithText:@"EMAIL VERIFICATION"];
    self.emailVerifiedTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:22.0f];
    self.emailVerifiedTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.emailVerifiedTitle];
    
    //self.emailVerifiedDescription
    self.emailVerifiedDescription = [[MPLabel alloc] initWithText:@"Verifying your email allows us to reset your password if you ever forget it."];
    self.emailVerifiedDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.emailVerifiedDescription];
    
    //self.emailVerifiedView
    self.emailVerifiedView = [[UIView alloc] init];
    self.emailVerifiedView.backgroundColor = [UIColor MPBlackColor];
    self.emailVerifiedView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.emailVerifiedView];
    
    //self.emailVerifiedImage
    self.emailVerifiedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_green.png"]];
    self.emailVerifiedImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.emailVerifiedImage.contentMode = UIViewContentModeCenter;
    [self.emailVerifiedView addSubview: self.emailVerifiedImage];
    
    //self.emailVerifiedButton
    self.emailVerifiedButton = [[MPPreferencesButton alloc] init];
    [self.emailVerifiedButton setCombinedTextColor:[UIColor MPGreenColor]];
    self.emailVerifiedButton.customTitleLabel.text = @"EMAIL VERIFIED";
    self.emailVerifiedButton.subtitleLabel.text = @"email | tap to change";
    [self.emailVerifiedView addSubview: self.emailVerifiedButton];
    
    [self bringSubviewToFront:self.menu];
}

- (void) setEmailVerified: (NSString*) email {
    [self.emailVerifiedButton setCombinedTextColor:[UIColor MPGreenColor]];
    self.emailVerifiedButton.customTitleLabel.text = @"EMAIL VERIFIED";
    self.emailVerifiedButton.subtitleLabel.text = [NSString stringWithFormat:@"%@ | tap to change", email];
    [self.emailVerifiedImage setImage:[UIImage imageNamed:@"check_green.png"]];
}

- (void) setEmailUnverified: (NSString*) email {
    [self.emailVerifiedButton setCombinedTextColor:[UIColor MPRedColor]];
    self.emailVerifiedButton.customTitleLabel.text = @"EMAIL NOT VERIFIED";
    self.emailVerifiedButton.subtitleLabel.text = [NSString stringWithFormat:@"%@ | tap to verify", email];
    [self.emailVerifiedImage setImage:[UIImage imageNamed:@"x_red.png"]];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.preferencesScrollView
                           [NSLayoutConstraint constraintWithItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.preferencesContentView
                           [NSLayoutConstraint constraintWithItem:self.preferencesContentView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.preferencesContentView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.preferencesContentView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.preferencesScrollView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.preferencesContentView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPSettingsView scrollingBounds].height],
                           //self.realNameTitle
                           [NSLayoutConstraint constraintWithItem:self.realNameTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.preferencesContentView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameTitle
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.realNameLabel
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.realNameTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.realNameField
                           [NSLayoutConstraint constraintWithItem:self.realNameField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.realNameField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.realNameField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.submitNameButton
                           [NSLayoutConstraint constraintWithItem:self.submitNameButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.realNameField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.submitNameButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.submitNameButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.changePasswordTitle
                           [NSLayoutConstraint constraintWithItem:self.changePasswordTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.submitNameButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordTitle
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.changePasswordLabel
                           [NSLayoutConstraint constraintWithItem:self.changePasswordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.changePasswordTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.changePasswordField
                           [NSLayoutConstraint constraintWithItem:self.changePasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.changePasswordLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.changePasswordField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.confirmPasswordLabel
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.changePasswordField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.confirmPasswordField
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmPasswordLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.oldPasswordLabel
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.oldPasswordField
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.oldPasswordLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordField
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordField
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.submitPasswordButton
                           [NSLayoutConstraint constraintWithItem:self.submitPasswordButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.oldPasswordField
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.submitPasswordButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.submitPasswordButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.friendRequestsTitle
                           [NSLayoutConstraint constraintWithItem:self.friendRequestsTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.submitPasswordButton
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
                           //self.emailVerifiedTitle
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmationAlertsView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedTitle
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedTitle
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.emailVerifiedDescription
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedDescription
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedDescription
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedDescription
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.emailVerifiedView
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedDescription
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:-10.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           //self.emailVerifiedImage
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedImage
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedImage
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedImage
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedImage
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:60.0f],
                           //self.emailVerifiedButton
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedImage
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailVerifiedButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailVerifiedView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],

                           ]];
}

+ (CGSize) scrollingBounds { return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 1100.0f); }

+ (NSString*) defaultSubtitle { return @"Settings"; }

@end
