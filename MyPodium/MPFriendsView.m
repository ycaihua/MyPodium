//
//  MPFriendsView.m
//  MyPodium
//
//  Created by Connor Neville on 5/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsView.h"
#import <Parse/Parse.h>

@implementation MPFriendsView

- (id) init {
    self = [super initWithTitleText:[PFUser currentUser].username subtitleText:@"friends list"];
    if(self) {
    }
    return self;
}

@end
