//
//  MPMakeTeamView.m
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMakeTeamView.h"
#import "UIColor+MPColor.h"

@implementation MPMakeTeamView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMakeTeamView defaultSubtitle]];
    if(self) {
        self.backgroundColor = [UIColor MPGrayColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    
}

- (void) makeControlConstraints {
    
}

+ (NSString*) defaultSubtitle { return @"New Team"; }

@end
