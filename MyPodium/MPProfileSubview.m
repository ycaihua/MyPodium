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
    [self makeSideBorder];
    [self makeGrayBorder];
    [self makeSidebarButton];
    [self makeContentTable];
}

- (void) makeSideBorder {
    self.sideBorder = [[UIView alloc] init];
    self.sideBorder.backgroundColor = [UIColor MPGreenColor];
    self.sideBorder.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.sideBorder];
    [self makeSideBorderConstraints];
}

- (void) makeSideBorderConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.sideBorder
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.sideBorder
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.sideBorder
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.sideBorder
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
                                                             toItem:self.sideBorder
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

- (void) makeContentTable {
    self.contentTable = [[UIView alloc] init];
    self.contentTable.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.contentTable];
    [self makeContentTableConstraints];
}

- (void) makeContentTableConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.contentTable
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.contentTable
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.sidebarButton
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0f
                                                           constant:8.0f],
                             [NSLayoutConstraint constraintWithItem:self.contentTable
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.contentTable
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailingMargin
                                                         multiplier:1.0f
                                                           constant:0.0f]
                             ];
    [self addConstraints: constraints];
}

@end
