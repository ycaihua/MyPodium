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

@interface MPMenuViewController ()

@end

@implementation MPMenuViewController

- (id) initWithActions: (BOOL) addActions {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] init];
        if(addActions) [self addControlActions];
    }
    return self;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//NOTE: addControlActions NOT called on construction because the containing
//mmDrawerController is nil until after login is complete (therefore
//this method is public and called later)
- (void) addControlActions {
    MPMenuView* view = (MPMenuView*) self.view;
    [view.menu.sidebarButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) menuButtonPressed: (id) sender {
    MMDrawerController* container = self.mm_drawerController;
    [container toggleDrawerSide:MMDrawerSideLeft animated:true completion:nil];
}

@end
