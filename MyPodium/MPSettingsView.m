//
//  MPSettingsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"
#import "UIColor+MPColor.h"

#import "MPSettingsView.h"
#import "MPBoldColorButton.h"

@implementation MPSettingsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPSettingsView defaultSubtitle]];
    if(self) {
        self.buttonColors = @[[UIColor MPBlackColor], [UIColor MPGreenColor],
                              [UIColor MPYellowColor], [UIColor MPRedColor]].mutableCopy;
        [self.buttonColors shuffle];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.accountDetailsButton
    self.accountDetailsButton = [[MPBoldColorButton alloc] init];
    self.accountDetailsButton.backgroundColor = self.buttonColors[0];
    if([self.accountDetailsButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.accountDetailsButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.accountDetailsButton setCombinedTextColor: [UIColor MPBlackColor]];
    }
    self.accountDetailsButton.customTitleLabel.text = @"ACCOUNT DETAILS";
    self.accountDetailsButton.subtitleLabel.text = @"change real name/password";
    self.accountDetailsButton.subtitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    [self addSubview: self.accountDetailsButton];
    
    //self.accountPreferencesButton
    self.accountPreferencesButton = [[MPBoldColorButton alloc] init];
    self.accountPreferencesButton.backgroundColor = self.buttonColors[1];
    if([self.accountPreferencesButton.backgroundColor isEqual: [UIColor MPBlackColor]]) {
        [self.accountPreferencesButton setCombinedTextColor: [UIColor whiteColor]];
    }
    else {
        [self.accountPreferencesButton setCombinedTextColor: [UIColor MPBlackColor]];
    }
    self.accountPreferencesButton.customTitleLabel.text = @"PREFERENCES";
    self.accountPreferencesButton.subtitleLabel.text = @"set default behaviors";
    self.accountPreferencesButton.subtitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:18.0f];
    [self addSubview: self.accountPreferencesButton];
    
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.accountDetailsButton
                           [NSLayoutConstraint constraintWithItem:self.accountDetailsButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.menu
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.accountDetailsButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.accountDetailsButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.accountPreferencesButton
                           [NSLayoutConstraint constraintWithItem:self.accountPreferencesButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.accountDetailsButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:10.0f],
                           [NSLayoutConstraint constraintWithItem:self.accountPreferencesButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.accountPreferencesButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.accountPreferencesButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:-10.0f],
                           [NSLayoutConstraint constraintWithItem:self.accountPreferencesButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.accountDetailsButton
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
    
}

+ (NSString*) defaultSubtitle { return @"Settings"; }

@end
