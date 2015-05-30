//
//  MPButtonWithSubtitle.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPButtonWithSubtitle.h"

@implementation MPButtonWithSubtitle

- (id) init {
    self = [super init];
    if(self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleLabel removeFromSuperview];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) setCombinedTextColor: (UIColor*) textColor {
    self.customTitleLabel.textColor = textColor;
    self.subtitleLabel.textColor = textColor;
}

- (void) makeControls {
    //self.customTitleLabel
    self.customTitleLabel = [[UILabel alloc] init];
    self.customTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.customTitleLabel.numberOfLines = 1;
    self.customTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.customTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.customTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.customTitleLabel.minimumScaleFactor = 0.3f;
    [self addSubview: self.customTitleLabel];
    
    //self.subtitleLabel
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitleLabel.numberOfLines = 1;
    self.subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.adjustsFontSizeToFitWidth = YES;
    self.subtitleLabel.minimumScaleFactor = 0.3f;
    [self addSubview: self.subtitleLabel];
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
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
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
@end
