//
//  MPControllerManager.m
//  MyPodium
//
//  Created by Connor Neville on 6/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPMenu.h"
#import "MPMenuView.h"

#import "MPMenuViewController.h"
#import "MPSidebarViewController.h"

#import "AppDelegate.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerController.h"

@implementation MPControllerManager

//Present view controller, handling cases depending on whether the controller to present should contain a drawer,
//whether the presenter is a drawer, and whether to add menu actions afterward
+ (void) presentViewController: (UIViewController*) controller fromController: (UIViewController*) presenter {
    
    UIViewController* toPresent = controller;
    if([controller isKindOfClass:[MPMenuViewController class]])
        toPresent = [AppDelegate makeDrawerWithCenterController:(MPMenuViewController*)controller];
    
    if(presenter.mm_drawerController)
        [presenter.mm_drawerController presentViewController:toPresent animated:true completion:nil];
    else
        [presenter presentViewController:toPresent animated:true completion:nil];
    
    if([presenter isKindOfClass:[MPMenuViewController class]]) {
        MPMenu* menu = ((MPMenuView*)presenter.view).menu;
        [menu hideIcons];
    }
    
    if([controller isKindOfClass:[MPMenuViewController class]]) {
        [(MPMenuViewController*)controller addMenuActions];
    }
}

//Dismiss view controller. If controller has a drawer, call it on the drawer. If the presenter
//responds to "refreshData", use that method.
+ (void) dismissViewController: (UIViewController*) controller {
    if(controller.mm_drawerController)
        [controller.mm_drawerController dismissViewControllerAnimated:true completion:nil];
    else
        [controller dismissViewControllerAnimated:true completion:nil];
    
    UIViewController* presenter = controller.presentingViewController;
    
    if([presenter isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController* presenterDrawer = (MMDrawerController*)presenter;
        [MPControllerManager updateNotificationsForController:presenterDrawer];
        MPMenuViewController* center = (MPMenuViewController*)presenterDrawer.centerViewController;
        
        if(center.delegate) {
            [center reloadData];
        }
        
        [(MMDrawerController*)presenter closeDrawerAnimated:NO completion:nil];
    }
    
    else {
        MPMenuViewController* presenterMenu = (MPMenuViewController*)presenter;
        if(presenterMenu.delegate) {
            [presenterMenu reloadData];
        }
    }
}

+ (void) updateNotificationsForController: (UIViewController*) controller {
    if([controller isKindOfClass:[MPMenuViewController class]]) {
        [self updateNotificationsForController: controller.mm_drawerController];
        return;
    }
    MMDrawerController* drawer = (MMDrawerController*)controller;
    MPMenuViewController* center = (MPMenuViewController*)drawer.centerViewController;
    [center checkNewNotifications];
    
    MPSidebarViewController* sidebar = (MPSidebarViewController*)drawer.leftDrawerViewController;
    [sidebar refresh];
}

@end
