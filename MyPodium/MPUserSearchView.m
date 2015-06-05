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
    self.searchView = [[UIView alloc] init];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.searchView];
    
    self.searchViewBottomBorder = [[UIView alloc] init];
    self.searchViewBottomBorder.backgroundColor = [UIColor MPDarkGrayColor];
    self.searchViewBottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchView addSubview: self.searchViewBottomBorder];
    
    self.searchField = [[MPTextField alloc] initWithPlaceholder:@"SEARCH USERS"];
    self.searchField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchView addSubview: self.searchField];
    
    self.searchButton = [[MPImageButton alloc] init];
    [self.searchButton setImageString:@"arrow_green"];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchView addSubview:self.searchButton];
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
                                                         constant:60.0f],
                           //self.searchViewBottomBorder
                           [NSLayoutConstraint constraintWithItem:self.searchViewBottomBorder
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchViewBottomBorder
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchViewBottomBorder
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchViewBottomBorder
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
                                                           toItem:self.searchView
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
                                                           toItem:self.searchView
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
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPImageButton standardWidthAndHeight]],
                           ]];
}

+ (NSString*) defaultSubtitle {
    return @"User Search";
}

@end
