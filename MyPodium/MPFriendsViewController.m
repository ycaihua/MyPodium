//
//  MPFriendsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsViewController.h"
#import "MPFriendsView.h"

@interface MPFriendsViewController ()

@end

@implementation MPFriendsViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPFriendsView alloc] init];
    }
    return self;
}
@end
