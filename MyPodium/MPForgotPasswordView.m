//
//  MPForgotPasswordView.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPForgotPasswordView.h"
#import "UIColor+MPColor.h"

@implementation MPForgotPasswordView

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
    self.titleLabel = [[CNLabel alloc] initWithText:@"FORGOT PASSWORD"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:30.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.titleLabel];
    
    //self.emailField
    self.emailField = [[MPTextField alloc] initWithPlaceholder:@"email"];
    self.emailField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.emailField];
    
    //self.descriptorLabel
    self.descriptorLabel = [[MPLabel alloc] initWithText:@"We'll send you an email with a link to reset your password."];
    self.descriptorLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptorLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.descriptorLabel];
    
    //self.resetPasswordButton
    self.resetPasswordButton = [[UIButton alloc] init];
    self.resetPasswordButton.backgroundColor = [UIColor MPBlackColor];
    [self.resetPasswordButton setTitle:@"RESET PASSWORD" forState:UIControlStateNormal];
    [self.resetPasswordButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateNormal];
    [self.resetPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.resetPasswordButton.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.resetPasswordButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.resetPasswordButton];
    
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
    [self addConstraints:@[//self.titleLabel
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
                           //self.emailField
                           [NSLayoutConstraint constraintWithItem:self.emailField
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
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
                                                         constant:35.0f],
                           //self.descriptorLabel
                           [NSLayoutConstraint constraintWithItem:self.descriptorLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailField
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
                           //self.resetPasswordButton
                           [NSLayoutConstraint constraintWithItem:self.resetPasswordButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.descriptorLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:12.0f],
                           [NSLayoutConstraint constraintWithItem:self.resetPasswordButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.resetPasswordButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.goBackButton
                           [NSLayoutConstraint constraintWithItem:self.goBackButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.resetPasswordButton
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
