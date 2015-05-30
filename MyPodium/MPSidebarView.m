//
//  MPSidebarView.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSidebarView.h"
#import "UIColor+MPColor.h"

@implementation MPSidebarView

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor MPBlackColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.logoView
    UIImage* logo = [UIImage imageNamed:@"barLogo200.png"];
    self.logoView = [[UIImageView alloc] initWithImage:logo];
    self.logoView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.logoView];
    
    //self.sidebarTable
    self.sidebarTable = [[UITableView alloc] init];
    self.sidebarTable.backgroundColor = [UIColor clearColor];
    self.sidebarTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.sidebarTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.sidebarTable.separatorColor = [UIColor MPYellowColor];
    self.sidebarTable.scrollEnabled = YES;
    [self addSubview: self.sidebarTable];
}

- (void) makeControlConstraints {
    [self addConstraints: @[//self.logoView
                            [NSLayoutConstraint constraintWithItem:self.logoView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTopMargin
                                                        multiplier:1.0f
                                                          constant:12.0f],
                            [NSLayoutConstraint constraintWithItem:self.logoView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.sidebarTable
                            [NSLayoutConstraint constraintWithItem:self.sidebarTable
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.logoView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.sidebarTable
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.sidebarTable
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.sidebarTable
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            ]];
}

@end
