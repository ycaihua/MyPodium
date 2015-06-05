//
//  MPUserSearchView.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPUserSearchView.h"
#import "UIColor+MPColor.h"

@implementation MPUserSearchView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPUserSearchView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {}
- (void) makeControlConstraints {}

+ (NSString*) defaultSubtitle {
    return @"User Search";
}

@end
