//
//  MPRegisterView.m
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPRegisterView.h"
#import "MPLabel.h"
#import "MPTextField.h"

@implementation MPRegisterView

- (id) init {
    self = [super init];
    if(self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"REGISTER"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:30.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.titleLabel];
    
    //self.usernameField
    self.usernameField = [[MPTextField alloc] initWithPlaceholder:@"username"];
    self.usernameField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.usernameField];
    
    //self.usernameLabel
    self.usernameLabel = [[MPLabel alloc] initWithText:@"4-12 letters, numbers and underscores"];
    self.usernameLabel.textAlignment = NSTextAlignmentCenter;
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.usernameLabel];
    
    //self.passwordField
    self.passwordField = [[MPTextField alloc] initWithPlaceholder:@"password"];
    self.passwordField.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.passwordField.secureTextEntry = TRUE;
    [self addSubview:self.passwordField];
    
    //self.passwordLabel
    self.passwordLabel = [[MPLabel alloc] initWithText:@"6-16 characters"];
    self.passwordLabel.textAlignment = NSTextAlignmentCenter;
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.passwordLabel];
    
    //self.emailField
    self.emailField = [[MPTextField alloc] initWithPlaceholder:@"email"];
    self.emailField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.emailField];
    
    //self.emailLabel
    self.emailLabel = [[MPLabel alloc] initWithText:@"must be a valid email"];
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    self.emailLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.emailLabel];
    
    //self.registerButton
    self.registerButton = [[UIButton alloc] init];
    self.registerButton.backgroundColor = [UIColor MPBlackColor];
    [self.registerButton setTitle:@"REGISTER" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.registerButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.registerButton];

    //self.descriptorLabel
    self.descriptorLabel = [[MPLabel alloc] initWithText:@"Once you register, we'll send you a verification email, then you're all set."];
    self.descriptorLabel.textAlignment = NSTextAlignmentLeft;
    self.descriptorLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.descriptorLabel];
    
    //self.goBackButton
    self.goBackButton = [[UIButton alloc] init];
    self.goBackButton.backgroundColor = [UIColor MPBlackColor];
    [self.goBackButton setTitle:@"GO BACK" forState:UIControlStateNormal];
    [self.goBackButton setTitleColor:[UIColor MPYellowColor] forState:UIControlStateNormal];
    [self.goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.goBackButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.goBackButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.goBackButton];
}

- (void) makeControlConstraints {
    [self addConstraints: @[//self.titleLabel
                            [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTopMargin
                                                        multiplier:1.0f
                                                          constant:18.0f],
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
                            //self.usernameField
                            [NSLayoutConstraint constraintWithItem:self.usernameField
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.titleLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:8.0f],
                            [NSLayoutConstraint constraintWithItem:self.usernameField
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.usernameField
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:[MPTextField standardWidth]],
                            [NSLayoutConstraint constraintWithItem:self.usernameField
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:[MPTextField standardHeight]],
                            //self.usernameLabel
                            [NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.usernameField
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.usernameLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.passwordField
                            [NSLayoutConstraint constraintWithItem:self.passwordField
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.usernameLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.passwordField
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.passwordField
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:[MPTextField standardWidth]],
                            [NSLayoutConstraint constraintWithItem:self.passwordField
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:[MPTextField standardHeight]],
                            //self.passwordLabel
                            [NSLayoutConstraint constraintWithItem:self.passwordLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.passwordField
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.passwordLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.passwordLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.emailField
                            [NSLayoutConstraint constraintWithItem:self.emailField
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.passwordLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.emailField
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.emailField
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:[MPTextField standardWidth]],
                            [NSLayoutConstraint constraintWithItem:self.emailField
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:[MPTextField standardHeight]],
                            //self.emailLabel
                            [NSLayoutConstraint constraintWithItem:self.emailLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.emailField
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.emailLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.emailLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.registerButton
                            [NSLayoutConstraint constraintWithItem:self.registerButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.emailLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:12.0f],
                            [NSLayoutConstraint constraintWithItem:self.registerButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.registerButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.descriptorLabel
                            [NSLayoutConstraint constraintWithItem:self.descriptorLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.registerButton
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:12.0f],
                            [NSLayoutConstraint constraintWithItem:self.descriptorLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.descriptorLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.goBackButton
                            [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.descriptorLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:12.0f],
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
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:0.0f]
                            ]];
}

@end