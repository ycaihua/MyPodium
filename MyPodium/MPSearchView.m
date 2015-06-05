//
//  MPSearchView.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSearchView.h"
#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

@implementation MPSearchView

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
    self.bottomBorder = [[UIView alloc] init];
    self.bottomBorder.backgroundColor = [UIColor MPDarkGrayColor];
    self.bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.bottomBorder];
    
    self.searchField = [[MPTextField alloc] initWithPlaceholder:@"SEARCH"];
    self.searchField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.searchField];
    
    self.searchButton = [[UIButton alloc] init];
    [self.searchButton setImageString:@"arrow" withColorString:@"green" withHighlightedColorString:@"black"];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.searchButton];
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
    //self.searchField
    [NSLayoutConstraint constraintWithItem:self.searchField
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeadingMargin
                                multiplier:1.0f
                                  constant:0.0f],
    [NSLayoutConstraint constraintWithItem:self.searchField
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.searchButton
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0f
                                  constant:-8.0f],
    [NSLayoutConstraint constraintWithItem:self.searchField
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f
                                  constant:0.0f],
    [NSLayoutConstraint constraintWithItem:self.searchField
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:[MPTextField standardHeight]],
    //self.searchButton
    [NSLayoutConstraint constraintWithItem:self.searchButton
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                  constant:0.0f],
    [NSLayoutConstraint constraintWithItem:self.searchButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0f
                                  constant:0.0f],
    [NSLayoutConstraint constraintWithItem:self.searchButton
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0f
                                  constant:0.0f],
    [NSLayoutConstraint constraintWithItem:self.searchButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:[UIButton standardWidthAndHeight]]
                           ]];
};

+ (CGFloat) standardHeight { return 60.0f; };

@end
