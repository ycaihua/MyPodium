//
//  MPFriendsView.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsView.h"
#import "UIColor+MPColor.h"

@implementation MPFriendsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPFriendsView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.friendsTable
    self.friendsTable = [[UITableView alloc] init];
    self.friendsTable.backgroundColor = [UIColor clearColor];
    self.friendsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.friendsTable.scrollEnabled = YES;
    self.friendsTable.delaysContentTouches = NO;
    [self addSubview: self.friendsTable];
    
    //self.loadingHeader
    self.loadingHeader = [[MPFriendsHeader alloc] initWithText:@"LOADING..."];
    self.loadingHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.loadingHeader];
}
- (void) makeControlConstraints {
    [self addConstraints:@[//self.friendsTable
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:16.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.friendsTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.loadingHeader
                           [NSLayoutConstraint constraintWithItem:self.loadingHeader
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:38.0f],
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
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Friends"; }
@end
