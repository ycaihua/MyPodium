//
//  MPRulesView.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPRulesView.h"
#import "UIColor+MPColor.h"

#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

@implementation MPRulesView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPRulesView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        self.searchAvailable = NO;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.filterSearch
    self.filterSearch = [[MPSearchControl alloc] init];
    [self.filterSearch.searchField setPlaceholder:@"FILTER MODES"];
    self.filterSearch.translatesAutoresizingMaskIntoConstraints = NO;
    
    //self.rulesTable
    self.rulesTable = [[UITableView alloc] init];
    self.rulesTable.backgroundColor = [UIColor clearColor];
    self.rulesTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.rulesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rulesTable.scrollEnabled = YES;
    [self addSubview: self.rulesTable];
    
    //self.searchButton
    self.searchButton = [[MPBottomEdgeButton alloc] init];
    [self.searchButton setTitle:@"SHOW SEARCH" forState:UIControlStateNormal];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchButton setBackgroundColor:[UIColor MPDarkGrayColor]];
    [self.searchButton setEnabled:NO];
    [self addSubview:self.searchButton];
    
    //self.makeRuleButton
    self.makeRuleButton = [[MPBottomEdgeButton alloc] init];
    [self.makeRuleButton setTitle:@"NEW RULE" forState:UIControlStateNormal];
    self.makeRuleButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.makeRuleButton];
}

- (void) finishLoading {
    [self.searchButton setEnabled:YES];
    [self.searchButton setBackgroundColor:[UIColor MPBlackColor]];
    [super finishLoading];
}

- (void) displaySearch {
    self.searchAvailable = YES;
    [self.searchButton setTitle:@"HIDE SEARCH" forState:UIControlStateNormal];
    [self addSubview: self.filterSearch];
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.rulesTable] &&
           constraint.firstAttribute == NSLayoutAttributeTop)
            [self removeConstraint: constraint];
    }
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
                           //self.rulesTable
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.filterSearch
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f]
                           ]];
}

- (void) hideSearch {
    [self.filterSearch removeFromSuperview];
    [self.searchButton setTitle:@"SHOW SEARCH" forState:UIControlStateNormal];
    self.searchAvailable = NO;
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.rulesTable] &&
           constraint.firstAttribute == NSLayoutAttributeTop)
            [self removeConstraint: constraint];
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rulesTable
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.menu
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0f
                                                      constant:8.0f]];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.rulesTable
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.rulesTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.searchButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           //self.searchButton
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-0.5f],
                           [NSLayoutConstraint constraintWithItem:self.searchButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]],
                           //self.makeRuleButton
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeRuleButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]]
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Rules"; }

@end
