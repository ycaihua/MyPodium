//
//  MPControllerManager.m
//  MyPodium
//
//  Created by Connor Neville on 6/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPMenuViewController.h"

#import "AppDelegate.h"
#import "UIViewController+MMDrawerController.h"

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
    
    if([controller isKindOfClass:[MPMenuViewController class]])
        [(MPMenuViewController*)controller addMenuActions];
}

//Dismiss view controller. If controller has a drawer, call it on the drawer. If the presenter
//responds to "refreshData", use that method.
+ (void) dismissViewController: (UIViewController*) controller {
    if(controller.mm_drawerController)
        [controller.mm_drawerController dismissViewControllerAnimated:true completion:nil];
    else
        [controller dismissViewControllerAnimated:true completion:nil];
    
    UIViewController* presenter = controller.presentingViewController;
    SEL refresh = sel_registerName("refreshData:");
    if([presenter respondsToSelector:refresh]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [presenter performSelector:refresh];
        #pragma clang diagnostic pop
    }
    
    if([presenter isKindOfClass:[MMDrawerController class]])
        [(MMDrawerController*)presenter closeDrawerAnimated:NO completion:nil];
}

@end
