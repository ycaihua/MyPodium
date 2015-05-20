//
//  MPProfileSubviewButton.m
//  MyPodium
//
//  Created by Connor Neville on 5/19/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileSubviewButton.h"

@implementation MPProfileSubviewButton

- (id) init {
    self = [super init];
    if(self) {
        [self removeExistingControls];
        [self makeControls];
    }
    return self;
}

- (void) removeExistingControls {
    for(UIView* subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void) makeControls {
    
}
@end
