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
        if(self.mm_drawerController) [self addMenuActions];
    }
    return self;
}

- (void) addMenuActions {
    MPMenuView* view = (MPMenuView*) self.view;
    MMDrawerController* container = self.mm_drawerController;
    //If the controller is not part of the root container
    if(container.presentingViewController) {
        MMDrawerController* presentingContainer = (MMDrawerController*)container.presentingViewController;
        MPMenuViewController* presentingMenu = (MPMenuViewController*)presentingContainer.centerViewController;
        MPMenuView* presentingMenuView = (MPMenuView*)presentingMenu.view;
        [view.menu displayTitlePressMessageForPageName:
         presentingMenuView.menu.subtitleLabel.persistentText];
        [view.menu.titleButton addTarget:self action:@selector(titleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    [view.menu.sidebarButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.menu.logOutButton addTarget:self action:@selector(logOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) titleButtonPressed: (id) sender {
    MMDrawerController* container = self.mm_drawerController;
    [container dismissViewControllerAnimated:true completion:nil];
    //In order to display the current controller, the presenter has
    //its menu open, so close it
    MMDrawerController* presenter = (MMDrawerController*)container.presentingViewController;
    [presenter toggleDrawerSide:MMDrawerSideLeft animated:true completion:nil];
    
}

- (void) menuButtonPressed: (id) sender {
    MMDrawerController* container = self.mm_drawerController;
    [container toggleDrawerSide:MMDrawerSideLeft animated:true completion:nil];
}

- (void) logOutButtonPressed: (id) sender {
    UIAlertController* logOutConfirmation = [UIAlertController alertControllerWithTitle:@"Log Out" message:@"Are you sure you want to log out?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Hacky solution to "menu-leak bug" - see readme
        [self presentViewController: [[UIViewController alloc] init] animated:NO completion:nil];
        
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        [delegate logOut];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [logOutConfirmation addAction: confirmAction];
    [logOutConfirmation addAction: cancelAction];
    [self presentViewController: logOutConfirmation animated: true completion:nil];
}

@end
