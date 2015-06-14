//
//  MPTeamsView.m
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPTeamsView.h"
#import "MPTableHeader.h"
#import "MPSearchView.h"
#import "MPTextField.h"

@implementation MPTeamsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPTeamsView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.filterSearch
    self.filterSearch = [[MPSearchView alloc] init];
    [self.filterSearch.searchField setPlaceholder:@"FILTER TEAMS"];
    self.filterSearch.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.filterSearch];
    
    //self.teamsTable
    self.teamsTable = [[UITableView alloc] init];
    self.teamsTable.backgroundColor = [UIColor clearColor];
    self.teamsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.teamsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.teamsTable.scrollEnabled = YES;
    self.teamsTable.delaysContentTouches = NO;
    [self addSubview: self.teamsTable];
    
    //self.loadingHeader
    self.loadingHeader = [[MPTableHeader alloc] initWithText:@"LOADING..."];
    self.loadingHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.loadingHeader];
}
- (void) makeControlConstraints {
    [self addConstraints:@[//self.filterSearch
                           [NSLayoutConstraint constraintWithItem:self.filterSearch
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:18.0f],
                           [NSLayoutConstraint constraintWithItem:self.filterSearch
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.filterSearch
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.filterSearch
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPSearchView standardHeight]],
                           //self.loadingHeader
                           [NSLayoutConstraint constraintWithItem:self.loadingHeader
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.filterSearch
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:-1.0f],
                           [NSLayoutConstraint constraintWithItem:self.loadingHeader
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.loadingHeader
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.teamsTable
                           [NSLayoutConstraint constraintWithItem:self.teamsTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.filterSearch
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamsTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamsTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.teamsTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Teams"; }

@end
