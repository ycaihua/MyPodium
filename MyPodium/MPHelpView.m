//
//  MPHelpView.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHelpView.h"

@implementation MPHelpView

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.logoButton
    self.logoButton = [[UIButton alloc] init];
    UIImage* image = [UIImage imageNamed:@"about_logo.png"];
    [self.logoButton setImage:image forState:UIControlStateNormal];
    [self.logoButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.logoButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.logoButton];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.logoButton
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:4.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

@end
