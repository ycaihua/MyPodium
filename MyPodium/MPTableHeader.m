//
//  MPTableHeader.m
//  MyPodium
//
//  Created by Connor Neville on 6/3/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTableHeader.h"
#import "UIColor+MPColor.h"
#import "CNLabel.h"

@implementation MPTableHeader

- (id) initWithText: (NSString*) text {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
        [self.headerLabel setText: text];
    }
    return self;
}

- (void) makeControls {
    //self.bottomBorder
    self.bottomBorder = [[UIView alloc] init];
    self.bottomBorder.backgroundColor = [UIColor MPDarkGrayColor];
    self.bottomBorder.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.bottomBorder];
    
    //self.headerLabel
    self.headerLabel = [[CNLabel alloc] initWithText:@"HEADER"];
    self.headerLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:20.0f];
    self.headerLabel.textColor = [UIColor MPBlackColor];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.headerLabel];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.bottomBorder
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:1.0f],
                           //self.headerLabel
                           [NSLayoutConstraint constraintWithItem:self.headerLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.headerLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.bottomBorder
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:6.0f],
                           
                           ]];
}

+ (CGFloat) headerHeight { return 25.0f; }

@end
