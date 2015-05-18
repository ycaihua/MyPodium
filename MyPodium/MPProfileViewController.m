//
//  MPProfileViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileViewController.h"
#import "MPProfileView.h"
#import <Parse/Parse.h>

@interface MPProfileViewController ()

@end

@implementation MPProfileViewController

- (id) initWithUser: (PFUser*) user {
    self = [super init];
    if(self) {
        MPProfileView* view = [[MPProfileView alloc] init];
        view.menu.titleLabel.text = [user.username uppercaseString];
        self.view = view;
    }
    return self;
}

@end
