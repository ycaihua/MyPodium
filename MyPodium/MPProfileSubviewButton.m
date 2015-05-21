//
//  MPProfileSubviewButton.m
//  MyPodium
//
//  Created by Connor Neville on 5/19/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileSubviewButton.h"
#import "UIColor+MPColor.h"

@implementation MPProfileSubviewButton

- (id) init {
    self = [super init];
    if(self) {
        [self removeExistingControls];
        [self makeControls];
    }
    return self;
}

- (void) removeExistingControls {
    for(UIView* subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void) makeControls {
    [self makeNumericTitleLabel];
    [self makeSubtitleLabel];
    [self makeTapToViewLabel];
    [self makeGrayBorder];
}

- (void) makeNumericTitleLabel {
    self.numericTitleLabel = [[CNLabel alloc] initWithText:@"1"];
    self.numericTitleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:32.0f];
    self.numericTitleLabel.textColor = [UIColor MPGreenColor];
    self.numericTitleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.numericTitleLabel];
    [self makeNumericTitleLabelConstraints];
}

- (void) makeNumericTitleLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.numericTitleLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.numericTitleLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f]                             ];
    [self addConstraints: constraints];
}

- (void) makeSubtitleLabel {
    self.subtitleLabel = [[CNLabel alloc] initWithText:@"SUBTITLE"];
    self.subtitleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:10.0f];
    self.subtitleLabel.textColor = [UIColor MPGreenColor];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.subtitleLabel];
    [self makeSubtitleLabelConstraints];
}

- (void) makeSubtitleLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.numericTitleLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
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
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeTapToViewLabel {
    self.tapToViewLabel = [[CNLabel alloc] initWithText:@"TAP TO VIEW"];
    self.tapToViewLabel.font = [UIFont fontWithName:@"Oswald-Light" size:10.0f];
    self.tapToViewLabel.textColor = [UIColor MPBlackColor];
    self.tapToViewLabel.textAlignment = NSTextAlignmentCenter;
    self.tapToViewLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.tapToViewLabel];
    [self makeTapToViewLabelConstraints];
}

- (void) makeTapToViewLabelConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.tapToViewLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.tapToViewLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeadingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.tapToViewLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
    
}

- (void) makeGrayBorder {
    self.grayBorder = [[UIView alloc] init];
    self.grayBorder.backgroundColor = [UIColor MPGrayColor];
    self.grayBorder.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.grayBorder];
    [self makeGrayBorderConstraints];
}

- (void) makeGrayBorderConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.grayBorder
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.grayBorder
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.grayBorder
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.grayBorder
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:1.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) applyPressDownStyle {
    [self.tapToViewLabel displayMessage:@"VIEW ALL" revertAfter:false withColor:[UIColor whiteColor]];
    [self.subtitleLabel displayMessage:self.subtitleLabel.text revertAfter:FALSE withColor:[UIColor whiteColor]];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:14.0f];
    [self.numericTitleLabel setTextColor: [UIColor clearColor]];
    [self setBackgroundColor:[UIColor MPBlackColor]];
}

- (void) revertPressDownStyle {
    [self.tapToViewLabel displayMessage:@"TAP TO VIEW ALL" revertAfter:false withColor:[UIColor MPBlackColor]];
    [self.subtitleLabel displayMessage:self.subtitleLabel.text revertAfter:FALSE withColor:[UIColor MPGreenColor]];
    self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
    self.subtitleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:10.0f];
    [self.numericTitleLabel setTextColor: [UIColor MPGreenColor]];
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
