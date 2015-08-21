//
//  MPMakeEventView.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMakeEventView.h"

@implementation MPMakeEventView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeEventView defaultSubtitle]];
    if(self) {
        
    }
    return self;
}

+ (NSString*) defaultSubtitle { return @"Create Event"; }

@end
