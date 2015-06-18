//
//  MPUserProfileViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPUserProfileViewController.h"
#import "MPUserProfileView.h"

@interface MPUserProfileViewController ()

@end

@implementation MPUserProfileViewController

- (id) initWithUser: (PFUser*)user {
    self = [super init];
    if(self) {
        MPUserProfileView* view = [[MPUserProfileView alloc] initWithUser: user];
        self.view = view;
        self.displayedUser = user;
    }
    return self;
}

@end
