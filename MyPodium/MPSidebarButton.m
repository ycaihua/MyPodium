//
//  MPSidebarButton.m
//  MyPodium
//
//  Created by Connor Neville on 5/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSidebarButton.h"
#import "UIColor+MPColor.h"

@implementation MPSidebarButton

- (id) init {
    self = [super init];
    if(self) {
        self.rowIndex = -1;
        [self adjustControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) adjustControls {
    //self.customTitleLabel
    self.customTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.customTitleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:20.0f];
    self.customTitleLabel.text = @"Button";
    self.customTitleLabel.textColor = [UIColor whiteColor];
    self.customTitleLabel.clipsToBounds = NO;
    
    //self.subtitleLabel
    [self.subtitleLabel removeFromSuperview];
}
- (void) makeControlConstraints {
    [self addConstraints: @[//self.customTitleLabel
                            [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f],
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
                            ]];
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    if(highlighted) {
        [self setCombinedTextColor: [UIColor MPYellowColor]];
    }
    else {
        [self setCombinedTextColor: [UIColor whiteColor]];
    }
}

- (void) cellButtonPressed: (id) sender {
    NSLog(@"Button press call on rowIndex %d", self.rowIndex);
}

@end
