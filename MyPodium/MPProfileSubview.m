//
//  MPProfileSubviewFriends.m
//  MyPodium
//
//  Created by Connor Neville on 5/19/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileSubview.h"
#import "UIColor+MPColor.h"

@implementation MPProfileSubview

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
    }
    return self;
}

- (void) makeControls {
    [self makeYellowBorder];
}

- (void) makeYellowBorder {
    self.yellowBorder = [[UIView alloc] init];
    self.yellowBorder.backgroundColor = [UIColor MPYellowColor];
}

@end
