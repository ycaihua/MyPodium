//
//  MPMenuViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "MPMenuView.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface MPMenuViewController ()

@end

@implementation MPMenuViewController

//Adding control actions require the drawer controller to be
//connected.
- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] init];
        if(self.mm_drawerController) [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPMenuView* view = (MPMenuView*) self.view;
    [view.menu.sidebarButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.menu.logOutButton addTarget:self action:@selector(logOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) menuButtonPressed: (id) sender {
    MMDrawerController* container = self.mm_drawerController;
    [container toggleDrawerSide:MMDrawerSideLeft animated:true completion:nil];
}

- (void) logOutButtonPressed: (id) sender {
    
    UIAlertController* logOutConfirmation = [UIAlertController alertControllerWithTitle:@"Log Out" message:@"Are you sure you want to log out?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        [delegate logOut];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    [logOutConfirmation addAction: cancelAction];
    [logOutConfirmation addAction: confirmAction];
    [self presentViewController: logOutConfirmation animated: true completion:nil];
}

@end
