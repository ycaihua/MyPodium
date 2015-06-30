//
//  MPMenu.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPMenu.h"
#import "CNLabel.h"

@implementation MPMenu

- (id) init {
    self = [super init];
    if(self) {
        [self setBackgroundColor:[UIColor MPBlackColor]];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleButton
    self.titleButton = [[UIButton alloc] init];
    [self.titleButton setTitle:@"TITLE" forState:UIControlStateNormal];
    [self.titleButton.titleLabel setFont: [UIFont fontWithName:@"Oswald-Bold" size:18.0f]];
    [self.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleButton setTitleColor:[UIColor MPYellowColor] forState:UIControlStateHighlighted];
    self.titleButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.titleButton];
    
    //self.subtitleLabel
    self.subtitleLabel = [[CNLabel alloc] initWithText:@"subtitle"];
    self.subtitleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:12.0f];
    self.subtitleLabel.textColor = [UIColor whiteColor];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.animationDelay = 2;
    self.subtitleLabel.numberOfLines = 2;
    [self addSubview: self.subtitleLabel];
    
    //self.sidebarButton
    UIImage *sidebarImg = [UIImage imageNamed:@"barIcon38.png"];
    UIImage* sidebarHighlightedImg = [UIImage imageNamed:@"barIcon_highlighted38.png"];
    self.sidebarButton = [[UIButton alloc] init];
    [self.sidebarButton setImage:sidebarImg forState:UIControlStateNormal];
    [self.sidebarButton setImage:sidebarHighlightedImg forState:UIControlStateHighlighted];
    self.sidebarButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.sidebarButton];
    
    //self.logOutButton
    UIImage* logOutImg = [UIImage imageNamed:@"logOutIcon38.png"];
    self.logOutButton = [[UIButton alloc] init];
    [self.logOutButton setImage:logOutImg forState:UIControlStateNormal];
    self.logOutButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.logOutButton];
    
    //These below controls not added by default
    //(requires double tap)
    
    //self.searchButton
    UIImage *searchImg = [UIImage imageNamed:@"searchIcon38.png"];
    self.searchButton = [[UIButton alloc] init];
    [self.searchButton setImage:searchImg forState:UIControlStateNormal];
    self.searchButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    
    //self.hideButton
    UIImage *hideImg = [UIImage imageNamed:@"hideIcon38.png"];
    self.hideButton = [[UIButton alloc] init];
    [self.hideButton setImage:hideImg forState:UIControlStateNormal];
    self.hideButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    
    //self.settingsButton
    UIImage *settingsImg = [UIImage imageNamed:@"settingsIcon38.png"];
    self.settingsButton = [[UIButton alloc] init];
    [self.settingsButton setImage:settingsImg forState:UIControlStateNormal];
    self.settingsButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    
    //Spacers used to allow for 5 buttons horizontally dispersed
    self.searchButtonSpacer = [[UIView alloc] init];
    self.searchButtonSpacer.backgroundColor = [UIColor clearColor];
    self.searchButtonSpacer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchButtonSpacer addSubview: self.searchButton];
    
    self.settingsButtonSpacer = [[UIView alloc] init];
    self.settingsButtonSpacer.backgroundColor = [UIColor clearColor];
    self.settingsButtonSpacer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.settingsButtonSpacer addSubview: self.settingsButton];
}

- (void) makeControlConstraints {
    [self addConstraints: @[//self.titleButton
                            [NSLayoutConstraint constraintWithItem:self.titleButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.sidebarButton
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.titleButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.logOutButton
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:-5.0f],
                             [NSLayoutConstraint constraintWithItem:self.titleButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.subtitleLabel
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                            //self.subtitleLabel
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.sidebarButton
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:5.0f],
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.logOutButton
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0f
                                                          constant:-5.0f],
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            //self.sidebarButton
                            [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:38.0f],
                            [NSLayoutConstraint constraintWithItem:self.sidebarButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:38.0f],
                            //self.logOutButton
                            [NSLayoutConstraint constraintWithItem:self.logOutButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.logOutButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottomMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.logOutButton
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:38.0f],
                            [NSLayoutConstraint constraintWithItem:self.logOutButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:38.0f],
                            ]];
}

+ (CGFloat) height { return 80.0f; }

@end
