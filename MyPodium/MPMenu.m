//
//  MPMenu.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenu.h"
#import "UIColor+MPColor.h"

@implementation MPMenu

- (id) init {
    self = [super init];
    if(self) {
        [self setBackgroundColor:[UIColor MPBlackColor]];
    }
    return self;
}

@end
