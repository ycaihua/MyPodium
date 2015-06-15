//
//  MPTeamsView.m
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPTeamsView.h"
#import "MPTeamsButton.h"
#import "MPTableHeader.h"
#import "MPSearchView.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

@implementation MPTeamsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPTeamsView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        self.searchAvailable = NO;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.loadingHeader
    self.loadingHeader = [[MPTableHeader alloc] initWithText:@"LOADING..."];
    self.loadingHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.loadingHeader];
    
    //self.filterSearch
    self.filterSearch = [[MPSearchView alloc] init];
    [self.filterSearch.searchField setPlaceholder:@"FILTER TEAMS"];
    self.filterSearch.translatesAutoresizingMaskIntoConstraints = NO;
    //NOT showing by default
    
    //self.teamsTable
    self.teamsTable = [[UITableView alloc] init];
    self.teamsTable.backgroundColor = [UIColor clearColor];
    self.teamsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.teamsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.teamsTable.scrollEnabled = YES;
    self.teamsTable.delaysContentTouches = NO;
    [self addSubview: self.teamsTable];
    
    //self.searchButton
    self.searchButton = [[MPTeamsButton alloc] init];
    [self.searchButton setTitle:@"SHOW SEARCH" forState:UIControlStateNormal];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchButton setBackgroundColor:[UIColor MPDarkGrayColor]];
    [self.searchButton setEnabled:NO];
    [self addSubview:self.searchButton];
    
    //self.makeTeamButton
    self.makeTeamButton = [[MPTeamsButton alloc] init];
    [self.makeTeamButton setTitle:@"NEW TEAM" forState:UIControlStateNormal];
    self.makeTeamButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.makeTeamButton];
}

- (void) finishLoading {
    [self.searchButton setEnabled:YES];
    [self.searchButton setBackgroundColor:[UIColor MPBlackColor]];
    [self.loadingHeader removeFromSuperview];
    [self.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
}

- (void) displaySearch {
    self.searchAvailable = YES;
    [self.searchButton setTitle:@"HIDE SEARCH" forState:UIControlStateNormal];
    [self addSubview: self.filterSearch];
    for(NSLayoutConstraint* constraint in self.constraints) {
        if([constraint.firstItem isEqual: self.teamsTable] &&
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
                                   constant:[MPSearchView standardHeight]],
     //self.teamsTable
     [NSLayoutConstraint constraintWithItem:self.teamsTable
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
        if([constraint.firstItem isEqual: self.teamsTable] &&
           constraint.firstAttribute == NSLayoutAttributeTop)
            [self removeConstraint: constraint];
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.teamsTable
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.menu
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0f
                                                      constant:8.0f]];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.loadingHeader
                           [NSLayoutConstraint constraintWithItem:self.loadingHeader
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:8.0f],
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
                                                           toItem:self.menu
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
                                                         constant:[MPTeamsButton defaultHeight]],
                           //self.makeTeamButton
                           [NSLayoutConstraint constraintWithItem:self.makeTeamButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeTeamButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.5f],
                           [NSLayoutConstraint constraintWithItem:self.makeTeamButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.makeTeamButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:[MPTeamsButton defaultHeight]]
                           ]];
}

+ (NSString*) defaultSubtitle { return @"Teams"; }

@end
