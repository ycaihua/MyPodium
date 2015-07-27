//
//  MPRuleButton.m
//  MyPodium
//
//  Created by Connor Neville on 7/27/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPRuleButton.h"
#import "UIColor+MPColor.h"

@implementation MPRuleButton

- (id) init {
    self = [super init];
    if(self) {
        self.playerModeSelected = YES;
        [self adjustControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) adjustControls {
    self.backgroundColor = [UIColor MPBlackColor];
    [self setCombinedTextColor:[UIColor whiteColor]];
    
    //self.customTitleLabel
    self.customTitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    self.customTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.customTitleLabel.text = @"PLAYER VS. PLAYER GAMES";
    
    //self.subtitleLabel
    self.subtitleLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.text = @"tap to toggle";
    self.translatesAutoresizingMaskIntoConstraints = NO;
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
    if(self.playerModeSelected) {
        self.customTitleLabel.text = @"TEAM VS. TEAM GAMES";
        self.subtitleLabel.text = @"tap to toggle player vs. player";
    }
    else {
        self.customTitleLabel.text = @"PLAYER VS. PLAYER GAMES";
        self.subtitleLabel.text = @"tap to toggle team vs. team";
    }
    self.playerModeSelected = !self.playerModeSelected;
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(highlighted)
        [self setCombinedTextColor:[UIColor MPGreenColor]];
    else
        [self setCombinedTextColor:[UIColor whiteColor]];
}

+ (CGFloat) defaultHeight { return 60.0f; }

@end
