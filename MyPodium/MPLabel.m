//
//  MPLabel.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLabel.h"
#import "UIColor+MPColor.h"

@implementation MPLabel

- (id) init {
    self = [super init];
    if(self) {
        [self applyDefaultStyle];
    }
    return self;
}

- (id) initWithText:(NSString *)text {
    self = [super initWithText:text];
    if(self) {
        [self applyDefaultStyle];
    }
    return self;
}

- (void) applyDefaultStyle {
    self.textColor = [UIColor MPBlackColor];
    self.font = [UIFont fontWithName:@"Lato-Bold" size:14.0f];
}

@end
