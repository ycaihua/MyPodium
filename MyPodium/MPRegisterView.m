//
//  MPRegisterView.m
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"

#import "MPFormView.h"
#import "MPRegisterView.h"
#import "MPLabel.h"
#import "MPTextField.h"

#import "MPRegisterUsernameView.h"
#import "MPRegisterPasswordView.h"
#import "MPRegisterEmailView.h"
#import "MPRegisterDisplayNameView.h"

@implementation MPRegisterView

- (id) init {
    self = [super init];
    if(self) {
        [self setBackgroundColor:[UIColor MPGrayColor]];
        [self makeControls];
        [self makeControlConstraints];
        [self makeSlides];
        [self setFirstResponder];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"REGISTER"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:36.0f];
    self.titleLabel.textColor = [UIColor MPGreenColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.titleLabel];
    
    //self.form
    self.form = [[MPFormView alloc] init];
    self.form.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.form];
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
                            //self.form
                            [NSLayoutConstraint constraintWithItem:self.form
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.titleLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.form
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.form
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.form
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            ]];
}
- (void) makeSlides {
    self.form.slideViews = @[[[MPRegisterUsernameView alloc] init], [[MPRegisterPasswordView alloc] init],
                             [[MPRegisterEmailView alloc] init], [[MPRegisterDisplayNameView alloc] init]];
    [self.form addSlideViews];
}

- (void) setFirstResponder {
    MPRegisterUsernameView* nameView = (MPRegisterUsernameView*)[self.form slideWithClass:[MPRegisterUsernameView class]];
    [nameView.usernameField becomeFirstResponder];
}

@end