//
//  MPMenu.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenu.h"
#import "UIColor+MPColor.h"
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

- (void) displayTitlePressMessageForPageName: (NSString*) pageName {
    [self.subtitleLabel displayMessage:[NSString stringWithFormat: @"Tap above to return to %@",
                                        pageName] revertAfter:YES withColor:[UIColor MPYellowColor]];
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
    self.subtitleLabel.animationDelay = 2;
    [self addSubview: self.subtitleLabel];
    
    //self.sidebarButton
    UIImage *sidebarImg = [UIImage imageNamed:@"barIcon38.png"];
    self.sidebarButton = [[UIButton alloc] init];
    [self.sidebarButton setImage:sidebarImg forState:UIControlStateNormal];
    self.sidebarButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.sidebarButton];
    
    //self.logOutButton
    UIImage* logOutImg = [UIImage imageNamed:@"logOutIcon38.png"];
    self.logOutButton = [[UIButton alloc] init];
    [self.logOutButton setImage:logOutImg forState:UIControlStateNormal];
    self.logOutButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.logOutButton];
}

- (void) makeControlConstraints {
    [self addConstraints: @[//self.titleButton
                            [NSLayoutConstraint constraintWithItem:self.titleButton
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f],
                             [NSLayoutConstraint constraintWithItem:self.titleButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.subtitleLabel
                                                          attribute:NSLayoutAttributeTopMargin
                                                         multiplier:1.0f
                                                           constant:0.0f],
                            //self.subtitleLabel
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeBaseline
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
                                                         attribute:NSLayoutAttributeBaseline
                                                        multiplier:1.0f
                                                          constant:2.0f],
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
                                                            toItem:self.subtitleLabel
                                                         attribute:NSLayoutAttributeBaseline
                                                        multiplier:1.0f
                                                          constant:2.0f]
                            ]];
}

@end
