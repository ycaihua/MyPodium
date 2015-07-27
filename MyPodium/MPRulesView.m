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
    //NOT showing by default
    
    //self.modesTable
    self.modesTable = [[UITableView alloc] init];
    self.modesTable.backgroundColor = [UIColor clearColor];
    self.modesTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.modesTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.modesTable.scrollEnabled = YES;
    [self addSubview: self.modesTable];
    
    //self.searchButton
    self.searchButton = [[MPBottomEdgeButton alloc] init];
    [self.searchButton setTitle:@"SHOW SEARCH" forState:UIControlStateNormal];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchButton setBackgroundColor:[UIColor MPDarkGrayColor]];
    [self.searchButton setEnabled:NO];
    [self addSubview:self.searchButton];
    
    //self.makeGameModeButton
    self.makeGameModeButton = [[MPBottomEdgeButton alloc] init];
    [self.makeGameModeButton setTitle:@"NEW MODE" forState:UIControlStateNormal];
    self.makeGameModeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.makeGameModeButton];
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
        if([constraint.firstItem isEqual: self.modesTable] &&
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
                           //self.modesTable
                           [NSLayoutConstraint constraintWithItem:self.modesTable
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
        if([constraint.firstItem isEqual: self.modesTable] &&
           constraint.firstAttribute == NSLayoutAttributeTop)
            [self removeConstraint: constraint];
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.modesTable
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.menu
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0f
                                                      constant:8.0f]];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.modesTable
                           [NSLayoutConstraint constraintWithItem:self.modesTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.modesTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.modesTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.modesTable
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
                           //self.makeGameModeButton
                           [NSLayoutConstraint constraintWithItem:self.makeGameModeButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeGameModeButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.makeGameModeButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeGameModeButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPBottomEdgeButton defaultHeight]]
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Game Modes"; }

@end
