//
//  MPHomeButton.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHomeButton.h"
#import "UIColor+MPColor.h"

@implementation MPHomeButton

- (id) init {
    self = [super init];
    if(self) {
        self.customTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.customTitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:44.0f];
        self.customTitleLabel.text = @"0";
        self.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.subtitleLabel.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    if(highlighted) {
        [self setCombinedTextColor: [UIColor MPBlackColor]];
        self.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent: 0.0f];
    }
    else {
        self.layer.borderColor = [UIColor MPBlackColor].CGColor;
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:1.0f];
        if([self.backgroundColor isEqual: [UIColor MPBlackColor]]) {
            [self setCombinedTextColor: [UIColor whiteColor]];
        }
        else {
            [self setCombinedTextColor: [UIColor MPBlackColor]];
        }
    }
}
@end
