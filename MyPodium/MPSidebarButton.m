//
//  MPSidebarButton.m
//  MyPodium
//
//  Created by Connor Neville on 5/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPSidebarButton.h"

@implementation MPSidebarButton

- (id) init {
    self = [super init];
    if(self) {
        self.rowIndex = -1;
        //[self adjustStyle];
        [self adjustControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) adjustStyle {
    self.layer.borderColor = [UIColor MPYellowColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void) adjustControls {
    //self.customTitleLabel
    self.customTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.customTitleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:22.0f];
    self.customTitleLabel.text = @"Button";
    self.customTitleLabel.adjustsFontSizeToFitWidth = NO;
    self.customTitleLabel.textColor = [UIColor whiteColor];
    
    //self.subtitleLabel
    self.subtitleLabel.textAlignment = NSTextAlignmentRight;
    self.subtitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    self.subtitleLabel.text = @"";
    self.subtitleLabel.textColor = [UIColor MPBlackColor];
    
}
- (void) makeControlConstraints {
    [self addConstraints: @[//self.customTitleLabel
                            [NSLayoutConstraint constraintWithItem:self.customTitleLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
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
                                                            toItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.subtitleLabel
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeBaseline
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.customTitleLabel
                                                         attribute:NSLayoutAttributeBaseline
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            ]];
}

- (void) applyCurrentlyOpenStyle {
    self.currentlyOpen = YES;
    [self.customTitleLabel setTextColor:[UIColor MPBlackColor]];
    [self setBackgroundColor: [UIColor MPYellowColor]];
    self.subtitleLabel.text = @"OPEN";
}

- (void) applyNotOpenStyle {
    self.currentlyOpen = NO;
    [self.customTitleLabel setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor: [UIColor MPBlackColor]];
    self.subtitleLabel.text = @"";
}

- (void) applyHighlightedStyle {
    [self.customTitleLabel setTextColor:[UIColor MPBlackColor]];
    [self setBackgroundColor: [UIColor MPYellowColor]];
    self.subtitleLabel.textColor = [UIColor MPBlackColor];
}

- (void) applyDefaultStyle {
    [self.customTitleLabel setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor: [UIColor MPBlackColor]];
    self.subtitleLabel.textColor = [UIColor MPYellowColor];
}

- (void) applyNumericSubtitle: (int) number {
    self.subtitleLabel.textColor = [UIColor MPYellowColor];
    self.subtitleLabel.text = [NSString stringWithFormat:@"%d NEW", number];
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    if(self.currentlyOpen) {
        return;
    }
    else if(highlighted) {
        [self applyHighlightedStyle];
    }
    else {
        [self applyDefaultStyle];
    }
}

- (void) cellButtonPressed: (id) sender {
}

@end
