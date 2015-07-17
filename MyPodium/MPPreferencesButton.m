//
//  MPPreferencesButton.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPPreferencesButton.h"

@implementation MPPreferencesButton

- (id) init {
    self = [super init];
    if(self) {
        self.toggledOn = TRUE;
        [self adjustControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) adjustControls {
    [self setCombinedTextColor:[UIColor whiteColor]];
    
    //self.customTitleLabel
    self.customTitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    self.customTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.customTitleLabel.text = @"TOGGLED ON";
    
    //self.subtitleLabel
    self.subtitleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
    self.subtitleLabel.text = @"tap to toggle off";
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void) makeControlConstraints {
    [self addConstraints:@[
                           //self.customTitleLabel
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
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
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.customTitleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f]]];
}

- (void) toggleSelected {
    if(self.toggledOn) {
        self.customTitleLabel.text = @"TOGGLED OFF";
        self.subtitleLabel.text = @"tap to toggle on";
        if(self.referenceImage)
            [self.referenceImage setImage:[UIImage imageNamed:@"x_black.png"]];
    }
    else {
        self.customTitleLabel.text = @"TOGGLED ON";
        self.subtitleLabel.text = @"tap to toggle off";
        if(self.referenceImage)
            [self.referenceImage setImage:[UIImage imageNamed:@"check_black.png"]];
    }
    self.toggledOn = !self.toggledOn;
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(!self.referenceImage)
        return;
    if(highlighted)
        [self setCombinedTextColor:[UIColor MPGreenColor]];
    else
        [self setCombinedTextColor:[UIColor whiteColor]];
}

@end
