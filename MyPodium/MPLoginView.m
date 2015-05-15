//
//  MPLoginView.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLoginView.h"
#import "MPTextField.h"
#import "UIColor+MPColor.h"

@implementation MPLoginView

- (id) init {
    self = [super init];
    if(self) {
        [self makeControls];
    }
    return self;
}

- (void) makeControls {
    [self makeLogoView];
    [self makeUsernameField];
    [self makePasswordField];
    [self makeLoginButton];
    [self makeForgotPasswordButton];
    [self makeRegisterLabel];
    [self makeRegisterButton];
}

- (void) makeLogoView {
    UIImage* image = [UIImage imageNamed:@"logo600_flat.png"];
    self.logoView = [[UIImageView alloc] initWithImage:image];
    self.logoView.image = image;
    self.logoView.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.logoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.logoView];
    [self makeLogoViewConstraints];
}

- (void) makeLogoViewConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:-10.0f],
                             [NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeWidth
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
                                                             toItem:self.logoView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:-40.0f],
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

- (void) makePasswordField {
    self.passwordField = [[MPTextField alloc] initWithPlaceholder:@"password"];
    self.passwordField.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.passwordField.secureTextEntry = TRUE;
    [self addSubview:self.passwordField];
    [self makePasswordFieldConstraints];
}

- (void) makePasswordFieldConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.passwordField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.usernameField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
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

- (void) makeLoginButton {
    self.loginButton = [[UIButton alloc] init];
    self.loginButton.backgroundColor = [UIColor MPBlackColor];
    [self.loginButton setTitle:@"LOG IN" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.loginButton];
    [self makeLoginButtonConstraints];
}

- (void) makeLoginButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.loginButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.passwordField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
                             [NSLayoutConstraint constraintWithItem:self.loginButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.loginButton
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeForgotPasswordButton {
    self.forgotPasswordButton = [[UIButton alloc] init];
    self.forgotPasswordButton.backgroundColor = [UIColor MPBlackColor];
    [self.forgotPasswordButton setTitle:@"FORGOT PASSWORD" forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor MPRedColor] forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.forgotPasswordButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.forgotPasswordButton];
    [self makeForgotPasswordButtonConstraints];
}

- (void) makeForgotPasswordButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.forgotPasswordButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.loginButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeRegisterLabel {
    self.registerLabel = [[CNLabel alloc] initWithText:@"Don't have an account yet? Register one with just your email."];
    self.registerLabel.textAlignment = NSTextAlignmentCenter;
    self.registerLabel.textColor = [UIColor MPBlackColor];
    self.registerLabel.font = [UIFont fontWithName:@"Lato-Regular" size:14.0f];
    self.registerLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.registerLabel];
    [self makeRegisterLabelConstraints];
}

- (void) makeRegisterLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.registerLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.forgotPasswordButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
                             [NSLayoutConstraint constraintWithItem:self.registerLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.registerLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeRegisterButton {
    self.registerButton = [[UIButton alloc] init];
    self.registerButton.backgroundColor = [UIColor MPBlackColor];
    [self.registerButton setTitle:@"REGISTER" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor MPYellowColor] forState:UIControlStateNormal];
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
                                                             toItem:self.registerLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:8.0f],
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
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}
@end
