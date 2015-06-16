//
//  MPUserSearchView.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPUserSearchView.h"
#import "MPSearchView.h"

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
    //self.searchView
    self.searchView = [[MPSearchView alloc] init];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.searchView];
    
    //self.searchTable
    self.searchTable = [[UITableView alloc] init];
    self.searchTable.backgroundColor = [UIColor clearColor];
    self.searchTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchTable.scrollEnabled = YES;
    self.searchTable.delaysContentTouches = NO;
    self.searchTable.allowsSelection = NO;
    self.searchTable.allowsMultipleSelection = NO;
    [self addSubview: self.searchTable];
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
                           //self.searchTable
                           [NSLayoutConstraint constraintWithItem:self.searchTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

+ (NSString*) defaultSubtitle {
    return @"User Search";
}

@end
