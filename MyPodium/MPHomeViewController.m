//
//  MPHomeViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"
#import "MPGameModesModel.h"

#import "MPHomeView.h"
#import "MPHomeTipView.h"
#import "MPBoldColorButton.h"
#import "MPLabel.h"

#import "MMDrawerController.h"
#import "MPFriendsViewController.h"
#import "MPTeamsViewController.h"
#import "MPGameModesViewController.h"
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
        [self refreshData];
        [view.friendsButton addTarget:self action:@selector(friendsButtonPressed:)
                     forControlEvents:UIControlEventTouchUpInside];
        [view.teamsButton addTarget:self action:@selector(teamsButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
        [view.modesButton addTarget:self action:@selector(modesButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
        [view.tipView addTarget:self action:@selector(tipViewPressed:)
               forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

- (void) loadOnDismiss: (id) sender {
    [self refreshData];
}

- (void) refreshData {
    MPHomeView* view = (MPHomeView*) self.view;
    dispatch_queue_t friendsQueue = dispatch_queue_create("FriendsLabelQueue", 0);
    dispatch_async(friendsQueue, ^{
        NSInteger friends = [MPFriendsModel countFriendsForUser:[PFUser currentUser]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.friendsButton.customTitleLabel setText:
             [NSString stringWithFormat:@"%lu", (long)friends]];
        });
    });
    dispatch_queue_t teamsQueue = dispatch_queue_create("TeamsLabelQueue", 0);
    dispatch_async(teamsQueue, ^{
        NSInteger teams = [MPTeamsModel countTeamsContainingUser:[PFUser currentUser]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.teamsButton.customTitleLabel setText:
             [NSString stringWithFormat:@"%lu", (long)teams]];
        });
    });
    dispatch_queue_t gameModesQueue = dispatch_queue_create("ModesLabelQueue", 0);
    dispatch_async(gameModesQueue, ^{
        NSInteger modes = [MPGameModesModel countGameModesForUser:[PFUser currentUser]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.modesButton.customTitleLabel setText:
             [NSString stringWithFormat:@"%lu", (long)modes]];
        });
    });
    
}

- (void) tipViewPressed: (id) sender {
    MPHomeView* view = (MPHomeView*) self.view;
    [view toggleTips];
}

- (void) friendsButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPFriendsViewController alloc] init] fromController:self];
}

- (void) teamsButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPTeamsViewController alloc] init] fromController:self];
}

- (void) modesButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPGameModesViewController alloc] init] fromController:self];
}

@end
