//
//  MPProfileSubviewFriends.m
//  MyPodium
//
//  Created by Connor Neville on 5/19/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileSubview.h"
#import "UIColor+MPColor.h"

@implementation MPProfileSubview

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
    }
    return self;
}

- (void) makeControls {
    [self makeYellowBorder];
    [self makeGrayBorder];
    [self makeSidebarButton];
}

- (void) makeYellowBorder {
    self.yellowBorder = [[UIView alloc] init];
    self.yellowBorder.backgroundColor = [UIColor MPYellowColor];
    self.yellowBorder.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.yellowBorder];
    [self makeYellowBorderConstraints];
}

- (void) makeYellowBorderConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.yellowBorder
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.yellowBorder
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.yellowBorder
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.yellowBorder
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:3.0f]
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
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.grayBorder
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.yellowBorder
                                                          attribute:NSLayoutAttributeTrailing
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
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:1.0f]
                             ];
    [self addConstraints: constraints];
}

- (void) makeSidebarButton {
    self.sidebarButton = [[MPProfileSubviewButton alloc] init];
    self.sidebarButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.sidebarButton];
    [self makeSidebarButtonConstraints];
}

- (void) makeSidebarButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.25f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

@end
