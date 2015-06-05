//
//  MPUserSearchView.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPUserSearchView.h"
#import "UIColor+MPColor.h"

@implementation MPUserSearchView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPUserSearchView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    self.searchView = [[MPSearchView alloc] init];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.searchView];
}
- (void) makeControlConstraints {
    [self addConstraints:@[//self.searchView
                           [NSLayoutConstraint constraintWithItem:self.searchView
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchView
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPSearchView standardHeight]],
                           ]];
}

+ (NSString*) defaultSubtitle {
    return @"User Search";
}

@end
