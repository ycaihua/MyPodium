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
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.logoButton
    self.logoButton = [[UIButton alloc] init];
    UIImage* image = [UIImage imageNamed:@"logo_cropped.png"];
    [self.logoButton setImage:image forState:UIControlStateNormal];
    UIImage* highlight = [UIImage imageNamed:@"logo_cropped_highlight.png"];
    [self.logoButton setImage:highlight forState:UIControlStateHighlighted];
    [self.logoButton setImage:highlight forState:UIControlStateSelected];
    [self.logoButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.logoButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.logoButton];
    
    //self.logoTapLabel
    self.logoTapLabel = [[MPLabel alloc] initWithText:@"tap above for help and information"];
    self.logoTapLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.logoTapLabel];
    
    //self.usernameField
    self.usernameField = [[MPTextField alloc] initWithPlaceholder:@"username"];
    self.usernameField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.usernameField];
    
    //self.passwordField
    self.passwordField = [[MPTextField alloc] initWithPlaceholder:@"password"];
    self.passwordField.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.passwordField.secureTextEntry = TRUE;
    [self addSubview:self.passwordField];
    
    //self.loginButton
    self.loginButton = [[UIButton alloc] init];
    self.loginButton.backgroundColor = [UIColor MPBlackColor];
    [self.loginButton setTitle:@"LOG IN" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.loginButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.loginButton];
    
    //self.forgotPasswordButton
    self.forgotPasswordButton = [[UIButton alloc] init];
    self.forgotPasswordButton.backgroundColor = [UIColor MPBlackColor];
    [self.forgotPasswordButton setTitle:@"FORGOT PASSWORD" forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor MPRedColor] forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.forgotPasswordButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.forgotPasswordButton];
    
    //self.registerLabel
    self.registerLabel = [[MPLabel alloc] initWithText:@"Don't have an account yet? Register one with just your email."];
    self.registerLabel.textAlignment = NSTextAlignmentCenter;
    self.registerLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.registerLabel];
    
    //self.registerButton
    self.registerButton = [[UIButton alloc] init];
    self.registerButton.backgroundColor = [UIColor MPBlackColor];
    [self.registerButton setTitle:@"REGISTER" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor MPYellowColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.registerButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.registerButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.registerButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.logoView
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:4.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1.0f
                                                         constant:-28.0f],
                           //self.logoTapLabel
                           [NSLayoutConstraint constraintWithItem:self.logoTapLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoTapLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.logoButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           
                           //self.usernameField
                           [NSLayoutConstraint constraintWithItem:self.usernameField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.logoTapLabel
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
                           //self.passwordField
                           [NSLayoutConstraint constraintWithItem:self.passwordField
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
                                                         constant:[MPTextField standardWidth]],
                           [NSLayoutConstraint constraintWithItem:self.passwordField
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTextField standardHeight]],
                           //self.loginButton
                           [NSLayoutConstraint constraintWithItem:self.loginButton
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
                                                         constant:0.0f],
                           //self.forgotPasswordButton
                           [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton
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
                                                         constant:0.0f],
                           //self.registerLabel
                           [NSLayoutConstraint constraintWithItem:self.registerLabel
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
                                                         constant:0.0f],
                           //self.registerButton
                           [NSLayoutConstraint constraintWithItem:self.registerButton
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
                           ]];
}

- (void) animateLogoMovement {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.logoButton] &&
           (constraint.firstAttribute == NSLayoutAttributeCenterX)) {
            //Constant found by trial and error to align logo with next screen
            //(needs to use leading as attribute instead of center to work on
            //varying screen sizes)
            [self removeConstraint:constraint];
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.logoButton
                                          attribute:NSLayoutAttributeCenterX
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                          attribute:NSLayoutAttributeLeadingMargin
                                         multiplier:1.1f
                                           constant:28.0f]];
           }
    }
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void) revertAnimation {
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.logoButton] &&
           (constraint.firstAttribute == NSLayoutAttributeCenterX)) {
            [self removeConstraint:constraint];
            [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.logoButton
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                         attribute:NSLayoutAttributeCenterX
                                        multiplier:1.0f
                                          constant:0.0f]];
           }
    }
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.75f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished){
        [self.logoButton setImage:[UIImage imageNamed:@"logo_cropped.png"] forState:UIControlStateNormal];
    }];
}
@end
