//
//  MPLoginView.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLoginView.h"
#import "MPTextField.h"

@implementation MPLoginView

- (id) init {
    self = [super init];
    if(self) {
        [self createLogoView];
        [self createUsernameField];
        [self createPasswordField];
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

@end
