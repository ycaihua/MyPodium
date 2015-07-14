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
        self.expanded = YES;
        [self applyDefaultStyle];
        [self makeControls];
        [self makeControlConstraints];
        [self displayRandomTip];
    }
    return self;
}

- (void) applyDefaultStyle {
    self.backgroundColor = [UIColor MPBlackColor];
}

- (void) makeControls {
    //self.tipDescriptionLabel
    self.tipDescriptionLabel = [[MPLabel alloc] initWithText:@"TIP"];
    self.tipDescriptionLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:28.0f];
    self.tipDescriptionLabel.textColor = [UIColor whiteColor];
    self.tipDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.tipDescriptionLabel];
    
    //self.tipContentLabel
    self.tipContentLabel = [[MPLabel alloc] initWithText:@"Tip goes here"];
    self.tipContentLabel.textColor = [UIColor whiteColor];
    self.tipContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.tipContentLabel];
    
    //self.showOrHideLabel
    self.showOrHideLabel = [[MPLabel alloc] initWithText:@"tap to hide"];
    self.showOrHideLabel.font = [UIFont fontWithName:@"Lato-Regular" size:12.0f];
    self.showOrHideLabel.textColor = [UIColor MPGrayColor];
    self.showOrHideLabel.textAlignment = NSTextAlignmentCenter;
    self.showOrHideLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.showOrHideLabel];
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
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.tipContentLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.showOrHideLabel
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.showOrHideLabel
                           [NSLayoutConstraint constraintWithItem:self.showOrHideLabel
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.showOrHideLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

- (void) toggleExpanded {
    if(self.expanded) {
        self.tipContentLabel.hidden = YES;
        self.tipDescriptionLabel.hidden = YES;
        self.showOrHideLabel.text = @"tap to show tips";
    }
    else {
        self.tipContentLabel.hidden = NO;
        self.tipDescriptionLabel.hidden = NO;
        self.showOrHideLabel.text = @"tap to hide";
    }
    self.expanded = !self.expanded;
}

- (void) displayRandomTip {
    int index = arc4random_uniform((int)self.allTips.count);
    NSString* tip = self.allTips[index];
    self.tipContentLabel.text = tip;
}

+ (NSArray*) getAllTips {
    return @[@"You can always go back to the previous page by tapping \"My Podium\" at the top of the screen.",
             @"You can quickly access extra pages by holding down \"My Podium\" at the top of the screen.",
             @"More than for just sports, MyPodium works great for board, video and card games, too."
             ];
}

+ (CGFloat) defaultHeight { return 90.0f; }
+ (CGFloat) collapsedHeight { return 30.0f; }

@end
