//
//  MPHomeView.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHomeView.h"
#import "UIColor+MPColor.h"
#import "NSMutableArray+Shuffling.h"

@implementation MPHomeView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:@"Home"];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        self.buttonColors = @[[UIColor MPBlackColor], [UIColor MPGreenColor],
                              [UIColor MPYellowColor], [UIColor MPRedColor]].mutableCopy;
        [self.buttonColors shuffle];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.friendsButton
    self.friendsButton = [[MPHomeButton alloc] init];
    self.friendsButton.backgroundColor = self.buttonColors[0];
    if([self.friendsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.friendsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.friendsButton setCombinedTextColor: [UIColor MPBlackColor]];
    }
    self.friendsButton.subtitleLabel.text = @"FRIENDS";
    [self addSubview: self.friendsButton];
    
    //self.teamsButton
    self.teamsButton = [[MPHomeButton alloc] init];
    self.teamsButton.backgroundColor = self.buttonColors[1];
    if([self.teamsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.teamsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.teamsButton setCombinedTextColor: [UIColor MPBlackColor]];
    }
    self.teamsButton.subtitleLabel.text = @"TEAMS";
    [self addSubview: self.teamsButton];
    
    //self.modesButton
    self.modesButton = [[MPHomeButton alloc] init];
    self.modesButton.backgroundColor = self.buttonColors[2];
    if([self.modesButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.modesButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.modesButton setCombinedTextColor: [UIColor MPBlackColor]];
    }
    self.modesButton.subtitleLabel.text = @"MODES";
    [self addSubview: self.modesButton];
    
    //self.eventsButton
    self.eventsButton = [[MPHomeButton alloc] init];
    self.eventsButton.backgroundColor = self.buttonColors[3];
    if([self.eventsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.eventsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.eventsButton setCombinedTextColor: [UIColor MPBlackColor]];
    }
    self.eventsButton.subtitleLabel.text = @"EVENTS";
    [self addSubview: self.eventsButton];
}

- (void) makeControlConstraints {
    float buttonPadding = 8.0f;
    [self addConstraints: @[//self.friendsButton
                            [NSLayoutConstraint constraintWithItem:self.friendsButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:buttonPadding*2],
                            [NSLayoutConstraint constraintWithItem:self.friendsButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:-buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.friendsButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.menu
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:buttonPadding*2],
                            [NSLayoutConstraint constraintWithItem:self.friendsButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.modesButton
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0f
                                                          constant:-(2*buttonPadding)],
                            //self.teamsButton
                            [NSLayoutConstraint constraintWithItem:self.teamsButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.teamsButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:-(buttonPadding*2)],
                            [NSLayoutConstraint constraintWithItem:self.teamsButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.menu
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:buttonPadding*2],
                            [NSLayoutConstraint constraintWithItem:self.teamsButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.eventsButton
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0f
                                                          constant:-(2*buttonPadding)],
                            //self.gameModesButton
                            [NSLayoutConstraint constraintWithItem:self.modesButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:buttonPadding*2],
                            [NSLayoutConstraint constraintWithItem:self.modesButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:-buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.modesButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.friendsButton
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:2*buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.modesButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.friendsButton
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.modesButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0f
                                                          constant:-(buttonPadding*2)],
                            //self.eventsButton
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:-(buttonPadding*2)],
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.teamsButton
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:2*buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.teamsButton
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0f
                                                          constant:-(buttonPadding*2)],
                            ]];
}

@end
