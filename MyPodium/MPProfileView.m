//
//  MPProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileView.h"

@implementation MPProfileView

- (id) init {
    self = [super initWithTitleText:@"USERNAME" subtitleText:@"profile"];
    if(self) {
        [self makeControls];
    }
    return self;
}

- (void) makeControls {
    
}
@end
