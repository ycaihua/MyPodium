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
        [self makeSubtitle];
        [self makeSubtitleConstraints];
    }
    return self;
}

- (void) makeSubtitle {
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitleLabel.numberOfLines = 0;
    self.subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.subtitleLabel];
}

- (void) makeSubtitleConstraints {
    [self addConstraints:@[//self.subtitleLabel
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
                                                           toItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f]
                           ]];
}
@end
