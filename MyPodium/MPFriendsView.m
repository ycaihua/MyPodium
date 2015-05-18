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
    self = [super init];
    if(self) {
        self.menu.titleLabel.text = [PFUser currentUser].username;
        self.menu.subtitleLabel.text = @"friends list";
    }
    return self;
}

@end
