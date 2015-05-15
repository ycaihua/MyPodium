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
        [self createLogoView];
        [self createUsernameField];
        [self createPasswordField];
        [self createLoginButton];
        [self createForgotPasswordButton];
        [self createRegisterLabel];
    }
    return self;
}

- (void) createLogoView {
    UIImage* image = [UIImage imageNamed:@"logo600_flat.png"];
    self.logoView = [[UIImageView alloc] initWithImage:image];
    self.logoView.image = image;
    self.logoView.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.logoView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.logoView];
    [self createLogoViewConstraints];
}

//We don't need a constraint for height, because the
//content mode is set above to aspect fit
- (void) createLogoViewConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.logoView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
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

- (void) createUsernameField {
    self.usernameField = [[MPTextField alloc] init];
    self.usernameField.placeholder = @"username";
    self.usernameField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.usernameField];
    [self createUsernameFieldConstraints];
}

- (void) createUsernameFieldConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.usernameField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.logoView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:-30.0f],
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

- (void) createPasswordField {
    self.passwordField = [[MPTextField alloc] init];
    self.passwordField.placeholder = @"password";
    self.passwordField.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.passwordField.secureTextEntry = TRUE;
    [self addSubview:self.passwordField];
    [self createPasswordFieldConstraints];
}

- (void) createPasswordFieldConstraints {
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

- (void) createLoginButton {
    self.loginButton = [[UIButton alloc] init];
    self.loginButton.backgroundColor = [UIColor MPBlackColor];
    [self.loginButton setTitle:@"LOG IN" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.loginButton];
    [self createLoginButtonConstraints];
}

- (void) createLoginButtonConstraints {
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

- (void) createForgotPasswordButton {
    self.forgotPasswordButton = [[UIButton alloc] init];
    self.forgotPasswordButton.backgroundColor = [UIColor MPBlackColor];
    [self.forgotPasswordButton setTitle:@"FORGOT PASSWORD" forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor MPRedColor] forState:UIControlStateNormal];
    self.forgotPasswordButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.forgotPasswordButton];
    [self createForgotPasswordButtonConstraints];
}

- (void) createForgotPasswordButtonConstraints {
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

- (void) createRegisterLabel {
    
}
@end