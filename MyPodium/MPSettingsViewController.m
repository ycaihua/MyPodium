//
//  MPSettingsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPSettingsView.h"
#import "MPBoldColorButton.h"

#import "MPSettingsViewController.h"
#import "MPAccountDetailsViewController.h"

@interface MPSettingsViewController ()

@end

@implementation MPSettingsViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPSettingsView alloc] init];
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPSettingsView* view = (MPSettingsView*) self.view;
    [view.accountDetailsButton addTarget:self action:@selector(detailsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) detailsButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPAccountDetailsViewController alloc] init] fromController:self];
}

@end
