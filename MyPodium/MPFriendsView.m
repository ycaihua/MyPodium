//
//  MPFriendsView.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsView.h"

@implementation MPFriendsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:@"Friends"];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {//self.friendsTable
    self.friendsTable = [[UITableView alloc] init];
    self.friendsTable.backgroundColor = [UIColor clearColor];
    self.friendsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.friendsTable.scrollEnabled = YES;
    [self addSubview: self.friendsTable];
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
                                                         constant:0.0f]
                           ]];
}
@end
