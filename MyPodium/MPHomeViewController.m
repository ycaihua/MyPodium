//
//  MPHomeViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsModel.h"

#import "MPHomeView.h"
#import "MPHomeButton.h"
#import "CNLabel.h"

#import "MMDrawerController.h"
#import "MPFriendsViewController.h"
#import "MPHomeViewController.h"

#import "AppDelegate.h"

@interface MPHomeViewController ()

@end

@implementation MPHomeViewController

- (id) init {
    self = [super init];
    if(self) {
        MPHomeView* view = [[MPHomeView alloc] init];
        self.view = view;
        dispatch_queue_t backgroundQueue = dispatch_queue_create("HomeLabelsQueue", 0);
        dispatch_async(backgroundQueue, ^{
            NSArray* friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [view.friendsButton.customTitleLabel setText:
                 [NSString stringWithFormat:@"%lu", (unsigned long)friends.count]];
            });
        });
        [view.friendsButton addTarget:self action:@selector(friendsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) friendsButtonPressed: (id) sender {
    MPFriendsViewController* destination = [[MPFriendsViewController alloc] init];
    [self presentViewController:[AppDelegate makeDrawerWithCenterController:destination] animated:true completion:nil];
    [destination addMenuActions];
}

@end
