//
//  MPHomeButton.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHomeButton.h"
#import "UIColor+MPColor.h"

@implementation MPHomeButton

- (id) init {
    self = [super init];
    if(self) {
        self.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.layer.borderWidth = 2.0f;
        [self adjustControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) adjustControls {
    //self.customTitleLabel
    self.customTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.customTitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:44.0f];
    self.customTitleLabel.text = @"0";
    
    //self.subtitleLabel
    self.subtitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.customTitleLabel
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.subtitleLabel
                           [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    if(highlighted) {
        [self setCombinedTextColor: [UIColor MPBlackColor]];
        self.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent: 0.0f];
    }
    else {
        self.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:1.0f];
        if([self.backgroundColor isEqual: [UIColor MPBlackColor]]) {
            [self setCombinedTextColor: [UIColor whiteColor]];
        }
        else {
            [self setCombinedTextColor: [UIColor MPBlackColor]];
        }
    }
}
@end
