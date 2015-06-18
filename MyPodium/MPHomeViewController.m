//
//  MPHomeViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"

#import "MPHomeView.h"
#import "MPHomeButton.h"
#import "CNLabel.h"

#import "MMDrawerController.h"
#import "MPFriendsViewController.h"
#import "MPTeamsViewController.h"
#import "MPHomeViewController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPHomeViewController ()

@end

@implementation MPHomeViewController

- (id) init {
    self = [super init];
    if(self) {
        MPHomeView* view = [[MPHomeView alloc] init];
        self.view = view;
        dispatch_queue_t friendsQueue = dispatch_queue_create("FriendsLabelQueue", 0);
        dispatch_async(friendsQueue, ^{
            NSArray* friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [view.friendsButton.customTitleLabel setText:
                 [NSString stringWithFormat:@"%lu", (unsigned long)friends.count]];
            });
        });
        dispatch_queue_t teamsQueue = dispatch_queue_create("TeamsLabelQueue", 0);
        dispatch_async(teamsQueue, ^{
            NSArray* teams = [MPTeamsModel teamsContainingUser:[PFUser currentUser]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [view.teamsButton.customTitleLabel setText:
                 [NSString stringWithFormat:@"%lu", (unsigned long)teams.count]];
            });
        });
        [view.friendsButton addTarget:self action:@selector(friendsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view.teamsButton addTarget:self action:@selector(teamsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) friendsButtonPressed: (id) sender {
    MPFriendsViewController* destination = [[MPFriendsViewController alloc] init];
    [self.mm_drawerController presentViewController:[AppDelegate makeDrawerWithCenterController:destination] animated:true completion:nil];
    [destination addMenuActions];
}

- (void) teamsButtonPressed: (id) sender {
    MPTeamsViewController* destination = [[MPTeamsViewController alloc] init];
    [self.mm_drawerController presentViewController:[AppDelegate makeDrawerWithCenterController:destination] animated:true completion:nil];
    [destination addMenuActions];
    
}

@end
