//
//  MPMessageComposerView.m
//  MyPodium
//
//  Created by Connor Neville on 7/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMessageComposerView.h"

@implementation MPMessageComposerView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPMessageComposerView defaultSubtitle]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    
}

- (void) makeControlConstraints {
    
}

+ (NSString*) defaultSubtitle { return @"Compose Message"; }

@end
