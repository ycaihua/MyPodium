//
//  MPSettingsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPTextField.h"
#import "MPLabel.h"
#import "MPSettingsView.h"

@implementation MPSettingsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPSettingsView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.realNameField
    self.realNameField = [[MPTextField alloc] initWithPlaceholder:@"REAL NAME"];
    self.realNameField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.realNameField];
    
    //self.realNameLabel
    self.realNameLabel = [[MPLabel alloc] initWithText:@"You can optionally enter your real name here so your friends can identify you."];
    self.realNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.realNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.realNameLabel];
    
    //self.submitNameButton
    self.submitNameButton = [[UIButton alloc] init];
    self.submitNameButton.backgroundColor = [UIColor MPBlackColor];
    [self.submitNameButton setTitle:@"SAVE NAME" forState:UIControlStateNormal];
    [self.submitNameButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.submitNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.submitNameButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.submitNameButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.submitNameButton];
    
    //self.changePasswordField
    self.changePasswordField = [[MPTextField alloc] initWithPlaceholder:@"CHANGE PASSWORD"];
    self.changePasswordField.secureTextEntry = YES;
    self.changePasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.changePasswordField];
    
    //self.changePasswordLabel
    self.changePasswordLabel = [[MPLabel alloc] initWithText:@"If you want to change your password, enter a new one here."];
    self.changePasswordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.changePasswordLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.changePasswordLabel];
    
    //self.confirmPasswordField
    self.confirmPasswordField = [[MPTextField alloc] initWithPlaceholder:@"CONFIRM PASSWORD"];
    self.confirmPasswordField.secureTextEntry = YES;
    self.confirmPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.confirmPasswordField];
    
    //self.confirmPasswordLabel
    self.confirmPasswordLabel = [[MPLabel alloc] initWithText:@"Re-enter your new password to confirm it."];
    self.confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.confirmPasswordLabel];
    
    //self.oldPasswordField
    self.oldPasswordField = [[MPTextField alloc] initWithPlaceholder:@"OLD PASSWORD"];
    self.oldPasswordField.secureTextEntry = YES;
    self.oldPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.oldPasswordField];
    
    //self.oldPasswordLabel
    self.oldPasswordLabel = [[MPLabel alloc] initWithText:@"Enter your current password."];
    self.oldPasswordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.oldPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.oldPasswordLabel];
    
    //self.submitPasswordButton
    self.submitPasswordButton = [[UIButton alloc] init];
    self.submitPasswordButton.backgroundColor = [UIColor MPBlackColor];
    [self.submitPasswordButton setTitle:@"SAVE PASSWORD" forState:UIControlStateNormal];
    [self.submitPasswordButton setTitleColor:[UIColor MPYellowColor] forState:UIControlStateNormal];
    [self.submitPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.submitPasswordButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.submitPasswordButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.submitPasswordButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.realNameField
                           [NSLayoutConstraint constraintWithItem:self.realNameField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
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
                           //self.realNameLabel
                           [NSLayoutConstraint constraintWithItem:self.realNameLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.realNameField
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
                           //self.submitNameButton
                           [NSLayoutConstraint constraintWithItem:self.submitNameButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.realNameLabel
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
                           //self.changePasswordField
                           [NSLayoutConstraint constraintWithItem:self.changePasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.submitNameButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
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
                           //self.changePasswordLabel
                           [NSLayoutConstraint constraintWithItem:self.changePasswordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.changePasswordField
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
                           //self.confirmPasswordField
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.changePasswordLabel
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
                           //self.confirmPasswordLabel
                           [NSLayoutConstraint constraintWithItem:self.confirmPasswordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmPasswordField
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
                           //self.oldPasswordField
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.confirmPasswordLabel
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
                           //self.oldPasswordLabel
                           [NSLayoutConstraint constraintWithItem:self.oldPasswordLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.oldPasswordField
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
                           //self.submitPasswordButton
                           [NSLayoutConstraint constraintWithItem:self.submitPasswordButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.oldPasswordLabel
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
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Settings"; }

@end
