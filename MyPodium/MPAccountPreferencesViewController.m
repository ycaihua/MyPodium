//
//  MPAccountPreferencesViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPAccountPreferencesView.h"
#import "MPPreferencesButton.h"

#import "MPAccountPreferencesViewController.h"

@interface MPAccountPreferencesViewController ()

@end

@implementation MPAccountPreferencesViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPAccountPreferencesView alloc] init];
        [self makeControlActions];
        [self initializeUserPreferences];
    }
    return self;
}

- (void) makeControlActions {
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    [view.friendRequestsButton addTarget:self action:@selector(friendRequestsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.confirmationAlertsButton addTarget:self action:@selector(confirmationAlertsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) initializeUserPreferences {
    
}

- (void) friendRequestsButtonPressed: (id) sender {
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    [view.friendRequestsButton toggleSelected];
}

- (void) confirmationAlertsButtonPressed: (id) sender {
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    [view.confirmationAlertsButton toggleSelected];
}

@end
