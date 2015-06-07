//
//  MPViewWithMenu.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenu.h"
#import "MPMenuView.h"
#import "CNLabel.h"

@implementation MPMenuView

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeMenu];
        [self makeMenuConstraints];
    }
    return self;
}

- (id) initWithTitleText: (NSString*) titleText subtitleText: (NSString*) subtitleText {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeMenu];
        [self makeMenuConstraints];
        [self.menu.titleButton setTitle:titleText forState:UIControlStateNormal];
        self.menu.subtitleLabel.text = subtitleText;
    }
    return self;
}

- (void) makeMenu {
    self.menu = [[MPMenu alloc] init];
    self.menu.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.menu];
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
                                                           constant:[MPMenu height]]
                             ];
    [self addConstraints: constraints];
}

@end
