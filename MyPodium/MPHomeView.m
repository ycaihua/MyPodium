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
    UIFont* titleFont = [UIFont fontWithName:@"Oswald-Bold" size:44.0f];
    UIFont* subtitleFont = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    
    //self.friendsButton
    self.friendsButton = [[MPHomeButton alloc] init];
    self.friendsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.friendsButton.titleLabel.font = titleFont;
    self.friendsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.friendsButton setTitle:@"0" forState:UIControlStateNormal];
    self.friendsButton.backgroundColor = self.buttonColors[0];
    if([self.friendsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.friendsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.friendsButton setCombinedTextColor: [UIColor MPBlackColor]];
        self.friendsButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.friendsButton.layer.borderWidth = 2.0f;
    }
    self.friendsButton.subtitleLabel.text = @"FRIENDS";
    self.friendsButton.subtitleLabel.font = subtitleFont;
    self.friendsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.friendsButton];
    
    //self.teamsButton
    self.teamsButton = [[MPHomeButton alloc] init];
    self.teamsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.teamsButton.titleLabel.font = titleFont;
    self.teamsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.teamsButton setTitle:@"0" forState:UIControlStateNormal];
    self.teamsButton.backgroundColor = self.buttonColors[1];
    if([self.teamsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.teamsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.teamsButton setCombinedTextColor: [UIColor MPBlackColor]];
        self.teamsButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.teamsButton.layer.borderWidth = 2.0f;
    }
    self.teamsButton.subtitleLabel.text = @"TEAMS";
    self.teamsButton.subtitleLabel.font = subtitleFont;
    self.teamsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.teamsButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.teamsButton];
    
    //self.gameModesButton
    self.modesButton = [[MPHomeButton alloc] init];
    self.modesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.modesButton.titleLabel.font = titleFont;
    self.modesButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.modesButton setTitle:@"0" forState:UIControlStateNormal];
    self.modesButton.backgroundColor = self.buttonColors[2];
    if([self.modesButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.modesButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.modesButton setCombinedTextColor: [UIColor MPBlackColor]];
        self.modesButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.modesButton.layer.borderWidth = 2.0f;
    }
    self.modesButton.subtitleLabel.text = @"MODES";
    self.modesButton.subtitleLabel.font = subtitleFont;
    self.modesButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.modesButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.modesButton];
    
    //self.eventsButton
    self.eventsButton = [[MPHomeButton alloc] init];
    self.eventsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.eventsButton.titleLabel.font = titleFont;
    self.eventsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.eventsButton setTitle:@"0" forState:UIControlStateNormal];
    self.eventsButton.backgroundColor = self.buttonColors[3];
    if([self.eventsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.eventsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.eventsButton setCombinedTextColor: [UIColor MPBlackColor]];
        self.eventsButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.eventsButton.layer.borderWidth = 2.0f;
    }
    self.eventsButton.subtitleLabel.text = @"EVENTS";
    self.eventsButton.subtitleLabel.font = subtitleFont;
    self.eventsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventsButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
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
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0],
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
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0],
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
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:buttonPadding*2],
                            [NSLayoutConstraint constraintWithItem:self.modesButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.friendsButton
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:0.0f],
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
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:buttonPadding*2],
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.teamsButton
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            ]];
}

@end
