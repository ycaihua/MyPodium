//
//  MPHomeTipView.m
//  MyPodium
//
//  Created by Connor Neville on 7/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPHomeTipView.h"
#import "MPLabel.h"

@implementation MPHomeTipView

- (id) init {
    self = [super init];
    if(self) {
        self.allTips = [MPHomeTipView getAllTips];
        [self applyDefaultStyle];
        [self makeControls];
        [self makeControlConstraints];
        [self displayRandomTip];
    }
    return self;
}

- (void) applyDefaultStyle {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor MPBlackColor].CGColor;;
    self.layer.borderWidth = 2.0f;
    self.layer.cornerRadius = 10.0f;
}

- (void) makeControls {
    //self.tipDescriptionLabel
    self.tipDescriptionLabel = [[MPLabel alloc] initWithText:@"TIP"];
    self.tipDescriptionLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:28.0f];
    self.tipDescriptionLabel.textColor = [UIColor MPBlackColor];
    self.tipDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.tipDescriptionLabel];
    
    //self.tipContentLabel
    self.tipContentLabel = [[MPLabel alloc] initWithText:@"Tip goes here"];
    self.tipContentLabel.textColor = [UIColor MPBlackColor];
    self.tipContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.tipContentLabel];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.tipDescriptionLabel
                           [NSLayoutConstraint constraintWithItem:self.tipDescriptionLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.tipDescriptionLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.tipContentLabel
                           [NSLayoutConstraint constraintWithItem:self.tipContentLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.tipDescriptionLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.tipContentLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.tipContentLabel
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

- (void) displayRandomTip {
    int index = arc4random_uniform((int)self.allTips.count);
    NSString* tip = self.allTips[index];
    self.tipContentLabel.text = tip;
}

+ (NSArray*) getAllTips {
    return @[@"You can always go back to the previous page by tapping \"My Podium\" at the top of the screen.",
             @"You can quickly access the search and settings pages by holding down \"My Podium\" at the top of the screen."
             ];
}

+ (CGFloat) defaultHeight { return 80.0f; }

@end
