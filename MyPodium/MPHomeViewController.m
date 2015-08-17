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
#import "MPRulesModel.h"

#import "MPHomeView.h"
#import "MPHomeTipView.h"
#import "MPBoldColorButton.h"
#import "MPLabel.h"

#import "MMDrawerController.h"
#import "MPFriendsViewController.h"
#import "MPTeamsViewController.h"
#import "MPRulesViewController.h"
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
        self.delegate = self;
        [view.friendsButton addTarget:self action:@selector(friendsButtonPressed:)
                     forControlEvents:UIControlEventTouchUpInside];
        [view.teamsButton addTarget:self action:@selector(teamsButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
        [view.rulesButton addTarget:self action:@selector(rulesButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
        [view.tipView addTarget:self action:@selector(tipViewPressed:)
               forControlEvents: UIControlEventTouchUpInside];
        [self reloadData];
    }
    return self;
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPHomeViewController* homeVC = (MPHomeViewController*) controller;
    MPHomeView* view = (MPHomeView*)homeVC.view;
    
    NSInteger friends = [MPFriendsModel countFriendsForUser:[PFUser currentUser]];
    NSInteger teams = [MPTeamsModel countTeamsContainingUser:[PFUser currentUser]];
    NSInteger rules = [MPRulesModel countRulesForUser:[PFUser currentUser]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [view.friendsButton.customTitleLabel setText:
         [NSString stringWithFormat:@"%lu", (long)friends]];
        
        [view.teamsButton.customTitleLabel setText:
         [NSString stringWithFormat:@"%lu", (long)teams]];
        
        [view.rulesButton.customTitleLabel setText:
         [NSString stringWithFormat:@"%lu", (long)rules]];
    });
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    return nil;
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

- (void) rulesButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPRulesViewController alloc] init] fromController:self];
}

@end
