//
//  MPViewWithMenu.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@implementation MPMenuView

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
    }
    return self;
}

- (void) makeControls {
    [self makeMenu];
}

- (void) makeMenu {
    self.menu = [[MPMenu alloc] init];
    self.menu.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.menu];
    [self makeMenuConstraints];
}

- (void) makeMenuConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.menu
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.menu
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.menu
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0f
                                                           constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.menu
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f
                                                           constant:70.0f]
                             ];
    [self addConstraints: constraints];
}

@end
