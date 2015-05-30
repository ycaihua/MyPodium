//
//  MPSidebarView.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSidebarView.h"
#import "UIColor+MPColor.h"

@implementation MPSidebarView

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor MPBlackColor];
    }
    return self;
}

@end
