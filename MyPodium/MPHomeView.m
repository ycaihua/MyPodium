//
//  MPHomeView.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHomeView.h"

@implementation MPHomeView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:@"Home"];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
