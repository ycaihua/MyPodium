//
//  MPRegisterView.m
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPRegisterView.h"
#import "UIColor+MPColor.h"

@implementation MPRegisterView

- (id) init {
    self = [super init];
    if(self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self makeControls];
    }
    return self;
}

- (void) makeControls {
    [self makeTitleLabel];
    [self makeUsernameField];
    [self makeUsernameLabel];
    [self makePasswordField];
    [self makePasswordLabel];
    [self makeEmailField];
    [self makeEmailLabel];
    [self makeRegisterButton];
    [self makeDescriptorLabel];
    [self makeGoBackButton];
}

- (void) makeTitleLabel {
    self.titleLabel = [[CNLabel alloc] initWithText:@"REGISTER"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:30.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.titleLabel];
    [self makeTitleLabelConstraints];
}

- (void) makeTitleLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0f
                                                           constant:14.0f],
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
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeUsernameField {
    self.usernameField = [[MPTextField alloc] initWithPlaceholder:@"username"];
    self.usernameField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.usernameField];
    [self makeUsernameFieldConstraints];
}

- (void) makeUsernameFieldConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.usernameField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.titleLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
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
                                                           constant:190.0f],
                             [NSLayoutConstraint constraintWithItem:self.usernameField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:35.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeUsernameLabel {
    self.usernameLabel = [[CNLabel alloc] initWithText:@"4-12 characters: letters, numbers and underscores"];
    self.usernameLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.usernameLabel.textAlignment = NSTextAlignmentCenter;
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.usernameLabel];
    [self makeUsernameLabelConstraints];
}

- (void) makeUsernameLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.usernameLabel
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
                             ];
    [self addConstraints: constraints];
}

- (void) makePasswordField {
    self.passwordField = [[MPTextField alloc] initWithPlaceholder:@"password"];
    self.passwordField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.passwordField];
    [self makePasswordFieldConstraints];
}

- (void) makePasswordFieldConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.passwordField
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
                                                           constant:190.0f],
                             [NSLayoutConstraint constraintWithItem:self.passwordField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:35.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makePasswordLabel {
    self.passwordLabel = [[CNLabel alloc] initWithText:@"6-16 characters"];
    self.passwordLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.passwordLabel.textAlignment = NSTextAlignmentCenter;
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.passwordLabel];
    [self makePasswordLabelConstraints];
}

- (void) makePasswordLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.passwordLabel
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
                             ];
    [self addConstraints: constraints];
}

- (void) makeEmailField {
    self.emailField = [[MPTextField alloc] initWithPlaceholder:@"email"];
    self.emailField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.emailField];
    [self makeEmailFieldConstraints];
}

- (void) makeEmailFieldConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.emailField
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
                                                           constant:190.0f],
                             [NSLayoutConstraint constraintWithItem:self.emailField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:35.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeEmailLabel {
    self.emailLabel = [[CNLabel alloc] initWithText:@"will only be used to reset your password if needed"];
    self.emailLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    self.emailLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.emailLabel];
    [self makeEmailLabelConstraints];
}

- (void) makeEmailLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.emailLabel
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
                             ];
    [self addConstraints: constraints];
}

- (void) makeRegisterButton {
    self.registerButton = [[UIButton alloc] init];
    self.registerButton.backgroundColor = [UIColor MPBlackColor];
    [self.registerButton setTitle:@"REGISTER" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.registerButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.registerButton];
    [self makeRegisterButtonConstraints];
}

- (void) makeRegisterButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.registerButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.emailLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:5.0f],
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
                             ];
    [self addConstraints: constraints];
}

- (void) makeDescriptorLabel {
    self.descriptorLabel = [[CNLabel alloc] initWithText:@"Once you register, you can use the app right away. A verification email will be sent so that you can reset your password if you forget it."];
    self.descriptorLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.descriptorLabel.textAlignment = NSTextAlignmentLeft;
    self.descriptorLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.descriptorLabel];
    [self makeDescriptorLabelConstraints];
}

- (void) makeDescriptorLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.descriptorLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.registerButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:5.0f],
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
                             ];
    [self addConstraints: constraints];
}

- (void) makeGoBackButton {
    self.goBackButton = [[UIButton alloc] init];
    self.goBackButton.backgroundColor = [UIColor MPBlackColor];
    [self.goBackButton setTitle:@"GO BACK" forState:UIControlStateNormal];
    [self.goBackButton setTitleColor:[UIColor MPYellowColor] forState:UIControlStateNormal];
    [self.goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.goBackButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.goBackButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.goBackButton];
    [self makeGoBackButtonConstraints];
}

- (void) makeGoBackButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.goBackButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.descriptorLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:5.0f],
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
                                                           constant:0.0f],
                             ];
    [self addConstraints: constraints];
}

@end