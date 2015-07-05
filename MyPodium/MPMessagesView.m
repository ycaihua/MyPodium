//
//  MPMessagesView.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPBottomEdgeButton.h"
#import "MPMessagesView.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"

@implementation MPMessagesView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMessagesView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.filterSearch
    self.filterSearch = [[MPSearchControl alloc] init];
    [self.filterSearch.searchField setPlaceholder:@"FILTER MESSAGES"];
    self.filterSearch.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.filterSearch];
    
    //self.messagesTable
    self.messagesTable = [[UITableView alloc] init];
    self.messagesTable.backgroundColor = [UIColor clearColor];
    self.messagesTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.messagesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messagesTable.scrollEnabled = YES;
    self.messagesTable.delaysContentTouches = NO;
    self.messagesTable.allowsSelection = NO;
    self.messagesTable.allowsMultipleSelection = NO;
    [self addSubview: self.messagesTable];
    
    //self.loadingHeader
    self.loadingHeader = [[MPTableHeader alloc] initWithText:@"LOADING..."];
    self.loadingHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.loadingHeader];
    
    //self.composeButton
    self.composeButton = [[MPBottomEdgeButton alloc] init];
    [self.composeButton setTitle:@"COMPOSE MESSAGE" forState:UIControlStateNormal];
    self.composeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.composeButton];
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
                                                         constant:[MPSearchControl standardHeight]],
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
                           //self.messagesTable
                           [NSLayoutConstraint constraintWithItem:self.messagesTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.filterSearch
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.messagesTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.messagesTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.messagesTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.composeButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.composeButotn
                           [NSLayoutConstraint constraintWithItem:self.composeButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.composeButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.composeButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.composeButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Messages"; }
@end