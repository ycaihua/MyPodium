//
//  MPSettingsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSettingsView.h"

@implementation MPSettingsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPSettingsView defaultSubtitle]];
    if(self) {
        
    }
    return self;
}

+ (NSString*) defaultSubtitle { return @"Settings"; }

@end
