//
//  MPProfileControlBlock.m
//  MyPodium
//
//  Created by Connor Neville on 7/16/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPProfileControlBlock.h"
#import "MPBottomEdgeButton.h"
#import "UIColor+MPColor.h"

@implementation MPProfileControlBlock

- (id) init {
    self = [super init];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    self.buttons = @[[[MPBottomEdgeButton alloc] init],[[MPBottomEdgeButton alloc] init],[[MPBottomEdgeButton alloc] init],[[MPBottomEdgeButton alloc] init]];
    for(UIButton* button in self.buttons) {
        [button setTitle:@"BUTTON" forState:UIControlStateNormal];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview: button];
    }
}

- (void) makeControlConstraints {
    for(int i = 0; i < self.buttons.count; i++) {
        [self addConstraints:@[//constraints common to each button
                               [NSLayoutConstraint constraintWithItem:self.buttons[i]
                                                            attribute:NSLayoutAttributeLeading
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0f
                                                             constant:0.0f],
                               [NSLayoutConstraint constraintWithItem:self.buttons[i]
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1.0f
                                                             constant:0.0f]
                               ]];
    }
    
    [self addConstraints:@[//constraints common to each button
                           [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttons[0]
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:1.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[2]
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttons[1]
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:1.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[3]
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttons[2]
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:1.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[3]
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[0]
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttons[1]
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[1]
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttons[2]
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttons[2]
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttons[3]
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

- (void) setButtonTitles: (NSArray*) buttonTitles {
    for(int i = 0; i < self.buttons.count; i++) {
        MPBottomEdgeButton* button = self.buttons[i];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
    }
}

@end
