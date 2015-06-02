//
//  MPFriendsView.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsView.h"

@implementation MPFriendsView

- (id) init {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:@"Friends"];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {}
- (void) makeControlConstraints {}
@end
