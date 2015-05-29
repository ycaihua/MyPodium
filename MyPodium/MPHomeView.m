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
    self.friendsButton = [[MPButtonWithSubtitle alloc] init];
    self.friendsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.friendsButton.titleLabel.font = titleFont;
    self.friendsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.friendsButton setTitle:@"0" forState:UIControlStateNormal];
    self.friendsButton.backgroundColor = self.buttonColors[0];
    if([self.friendsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.friendsButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        self.friendsButton.subtitleLabel.textColor = [UIColor whiteColor];
    }
    else {
        [self.friendsButton setTitleColor: [UIColor MPBlackColor] forState:UIControlStateNormal];
        self.friendsButton.subtitleLabel.textColor = [UIColor MPBlackColor];
        self.friendsButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.friendsButton.layer.borderWidth = 2.0f;
    }
    self.friendsButton.subtitleLabel.text = @"FRIENDS";
    self.friendsButton.subtitleLabel.font = subtitleFont;
    self.friendsButton.layer.cornerRadius = 10;
    self.friendsButton.clipsToBounds = YES;
    self.friendsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.friendsButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.friendsButton];
    
    //self.teamsButton
    self.teamsButton = [[MPButtonWithSubtitle alloc] init];
    self.teamsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.teamsButton.titleLabel.font = titleFont;
    self.teamsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.teamsButton setTitle:@"0" forState:UIControlStateNormal];
    self.teamsButton.backgroundColor = self.buttonColors[1];
    if([self.teamsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.teamsButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        self.teamsButton.subtitleLabel.textColor = [UIColor whiteColor];
    }
    else {
        [self.teamsButton setTitleColor: [UIColor MPBlackColor] forState:UIControlStateNormal];
        self.teamsButton.subtitleLabel.textColor = [UIColor MPBlackColor];
        self.teamsButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.teamsButton.layer.borderWidth = 2.0f;
    }
    self.teamsButton.subtitleLabel.text = @"TEAMS";
    self.teamsButton.subtitleLabel.font = subtitleFont;
    self.teamsButton.layer.cornerRadius = 10;
    self.teamsButton.clipsToBounds = YES;
    self.teamsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.teamsButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.teamsButton];
    
    //self.gameModesButton
    self.gameModesButton = [[MPButtonWithSubtitle alloc] init];
    self.gameModesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.gameModesButton.titleLabel.font = titleFont;
    self.gameModesButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.gameModesButton setTitle:@"0" forState:UIControlStateNormal];
    self.gameModesButton.backgroundColor = self.buttonColors[2];
    if([self.gameModesButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.gameModesButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        self.gameModesButton.subtitleLabel.textColor = [UIColor whiteColor];
    }
    else {
        [self.gameModesButton setTitleColor: [UIColor MPBlackColor] forState:UIControlStateNormal];
        self.gameModesButton.subtitleLabel.textColor = [UIColor MPBlackColor];
        self.gameModesButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.gameModesButton.layer.borderWidth = 2.0f;
    }
    self.gameModesButton.subtitleLabel.text = @"GAME\nMODES";
    self.gameModesButton.subtitleLabel.font = subtitleFont;
    self.gameModesButton.layer.cornerRadius = 10;
    self.gameModesButton.clipsToBounds = YES;
    self.gameModesButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.gameModesButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.gameModesButton];
    
    //self.eventsButton
    self.eventsButton = [[MPButtonWithSubtitle alloc] init];
    self.eventsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.eventsButton.titleLabel.font = titleFont;
    self.eventsButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.eventsButton setTitle:@"0" forState:UIControlStateNormal];
    self.eventsButton.backgroundColor = self.buttonColors[3];
    if([self.eventsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.eventsButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        self.eventsButton.subtitleLabel.textColor = [UIColor whiteColor];
    }
    else {
        [self.eventsButton setTitleColor: [UIColor MPBlackColor] forState:UIControlStateNormal];
        self.eventsButton.subtitleLabel.textColor = [UIColor MPBlackColor];
        self.eventsButton.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.eventsButton.layer.borderWidth = 2.0f;
    }
    self.eventsButton.subtitleLabel.text = @"EVENTS";
    self.eventsButton.subtitleLabel.font = subtitleFont;
    self.eventsButton.layer.cornerRadius = 10;
    self.eventsButton.clipsToBounds = YES;
    self.eventsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventsButton.titleEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self addSubview: self.eventsButton];
}

- (void) makeControlConstraints {
    float buttonPadding = 15.0f;
    [self addConstraints: @[//self.friendsButton
                            [NSLayoutConstraint constraintWithItem:self.friendsButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
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
                                                          constant:buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.friendsButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:-buttonPadding],
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
                                                          constant:-buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.teamsButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.menu
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.teamsButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:-buttonPadding],
                            //self.gameModesButton
                            [NSLayoutConstraint constraintWithItem:self.gameModesButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.gameModesButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:-buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.gameModesButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.gameModesButton
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
                                                          constant:-buttonPadding],
                            [NSLayoutConstraint constraintWithItem:self.eventsButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:buttonPadding],
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
