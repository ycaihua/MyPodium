//
//  MPEventTypeView.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"
#import "UIColor+MPColor.h"

#import "MPEventTypeView.h"

@implementation MPEventTypeView

- (id) init {
    self = [super init];
    if(self) {
        self.selectedIndex = 0;
        self.allImages = @[[UIImage imageNamed:@"event_match150.png"],
                           [UIImage imageNamed:@"event_tournament150.png"],
                           [UIImage imageNamed:@"event_league150.png"],
                           [UIImage imageNamed:@"event_ladder150.png"]];
        self.allSmallImages = @[[UIImage imageNamed:@"event_match60.png"],
                                [UIImage imageNamed:@"event_tournament60.png"],
                                [UIImage imageNamed:@"event_league60.png"],
                                [UIImage imageNamed:@"event_ladder60.png"]];
        self.allTitles = @[@"MATCH",
                           @"TOURNAMENT",
                           @"LEAGUE",
                           @"LADDER"];
        self.allDescriptions = @[@"Play a quick single match without the commitment of the other event types.",
                                 @"Create a single or double elimination tournament. We'll setup a bracket for you.",
                                 @"Play in a league format that schedules a series of matches in rounds.",
                                 @"Make an ongoing ladder in which match winners climb to the top."];
        self.smallImageColors = @[[UIColor MPRedColor],
                                  [UIColor MPYellowColor],
                                  [UIColor MPGreenColor],
                                  [UIColor whiteColor]].mutableCopy;
        [self.smallImageColors shuffle];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) changeIndexSelected:(int)newIndex {
    self.selectedIndex = newIndex;
    self.currentImageView.image = self.allImages[self.selectedIndex];
    [self.currentTitle displayMessage:self.allTitles[self.selectedIndex] revertAfter:NO];
    [self.currentDescription displayMessage:self.allDescriptions[self.selectedIndex] revertAfter:NO];
}

- (MPEventType) selectedEventType {
    return self.selectedIndex;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:@"CHOOSE EVENT TYPE"];
    self.titleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.titleLabel];
    
    //self.currentImageView
    self.currentImageView = [[UIImageView alloc] initWithImage:self.allImages[self.selectedIndex]];
    self.currentImageView.layer.cornerRadius = 5.0f;
    self.currentImageView.layer.borderWidth = 2.0f;
    self.currentImageView.layer.borderColor = [UIColor MPBlackColor].CGColor;
    self.currentImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.currentImageView];
    
    //self.currentTitle
    self.currentTitle = [[MPLabel alloc] initWithText:self.allTitles[self.selectedIndex]];
    self.currentTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    [self addSubview: self.currentTitle];
    
    //self.currentDescription
    self.currentDescription = [[MPLabel alloc] initWithText:self.allDescriptions[self.selectedIndex]];
    self.currentDescription.textAlignment = NSTextAlignmentCenter;
    self.currentDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.currentDescription];
    
    //self.allButtons
    self.allButtons = @[[[UIButton alloc] init],
                        [[UIButton alloc] init],
                        [[UIButton alloc] init],
                        [[UIButton alloc] init]];
    for(int i = 0; i < self.allButtons.count; i++) {
        UIButton* button = self.allButtons[i];
        [button setImage:self.allSmallImages[i] forState:UIControlStateNormal];
        button.backgroundColor = self.smallImageColors[i];
        button.layer.cornerRadius = 5.0f;
        button.layer.borderWidth = 2.0f;
        button.layer.borderColor = [UIColor MPBlackColor].CGColor;
        button.clipsToBounds = YES;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
    }
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.titleLabel
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.currentImageView
                           [NSLayoutConstraint constraintWithItem:self.currentImageView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.currentImageView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.allButtons[0]
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.currentTitle
                           [NSLayoutConstraint constraintWithItem:self.currentTitle
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.currentTitle
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.currentImageView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.currentDescription
                           [NSLayoutConstraint constraintWithItem:self.currentDescription
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.currentDescription
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.currentDescription
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.currentTitle
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           //self.allButtons[0]
                           [NSLayoutConstraint constraintWithItem:self.allButtons[0]
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.allButtons[1]
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.0f
                                                         constant:-5.0f],
                           //self.allButtons[1]
                           [NSLayoutConstraint constraintWithItem:self.allButtons[1]
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:-2.5f],
                           //self.allButtons[2]
                           [NSLayoutConstraint constraintWithItem:self.allButtons[2]
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:2.5f],
                           //self.allButtons[3]
                           [NSLayoutConstraint constraintWithItem:self.allButtons[3]
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.allButtons[2]
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           ]];
    //repeated constraints for each imageview
    for(UIButton* button in self.allButtons) {
        [self addConstraints:@[[NSLayoutConstraint constraintWithItem:button
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.titleLabel
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0f
                                                             constant:5.0f],
                               ]];
    }
}

@end
