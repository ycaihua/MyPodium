//
//  MPForgotPasswordView.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPForgotPasswordView.h"

@implementation MPForgotPasswordView

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
}

- (void) makeTitleLabel {
    self.titleLabel = [[CNLabel alloc] initWithText:@"FORGOT PASSWORD"];
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

@end
