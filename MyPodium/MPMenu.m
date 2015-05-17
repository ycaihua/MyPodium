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
    }
    return self;
}

- (void) makeControls {
    [self makeSubtitleLabel];
    [self makeTitleLabel];
    [self makeSidebarButton];
}

- (void) makeSubtitleLabel {
    self.subtitleLabel = [[CNLabel alloc] initWithText:@"subtitle"];
    self.subtitleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:12.0f];
    self.subtitleLabel.textColor = [UIColor whiteColor];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.subtitleLabel];
    [self makeSubtitleLabelConstraints];
}

- (void) makeSubtitleLabelConstraints {
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0f
                                   constant:0.0f]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.subtitleLabel
                                  attribute:NSLayoutAttributeBaseline
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottomMargin
                                 multiplier:1.0f
                                   constant:0.0f]];
}

- (void) makeTitleLabel {
    self.titleLabel = [[CNLabel alloc] initWithText:@"TITLE"];
    [self.titleLabel setFont: [UIFont fontWithName:@"Oswald-Bold" size:18.0f]];
    [self.titleLabel setTextColor: [UIColor whiteColor]];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview: self.titleLabel];
    [self makeTitleLabelConstraints];
}

- (void) makeTitleLabelConstraints {
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.titleLabel
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0f
                                   constant:0.0f]];
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.titleLabel
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.subtitleLabel
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1.0f
                                   constant:0.0f]];
}

- (void) makeSidebarButton {
    UIImage *btnImage = [UIImage imageNamed:@"barIcon38.png"];
    self.sidebarButton = [[UIButton alloc] init];
    [self.sidebarButton setImage:btnImage forState:UIControlStateNormal];
    self.sidebarButton.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:self.sidebarButton];
    [self makeSidebarButtonConstraints];
}

- (void) makeSidebarButtonConstraints {
    NSArray* constraints = @[[NSLayoutConstraint constraintWithItem:self.sidebarButton
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
                                                           constant:2.0f]
                             ];
    [self addConstraints: constraints];
}

@end
