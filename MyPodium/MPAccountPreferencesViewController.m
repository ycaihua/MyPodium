//
//  MPAccountPreferencesViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPAccountPreferencesView.h"
#import "MPPreferencesButton.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPAccountPreferencesViewController.h"

#import <Parse/Parse.h>

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
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    PFUser* currentUser = [PFUser currentUser];
    
    NSNumber* prefFriendRequests = [currentUser objectForKey:@"pref_friendRequests"];
    if([prefFriendRequests isEqual: [NSNumber numberWithBool:FALSE]]) [view.friendRequestsButton toggleSelected];
    
    NSNumber* prefConfirmations = [currentUser objectForKey:@"pref_confirmation"];
    if([prefConfirmations isEqual: [NSNumber numberWithBool:FALSE]]) [view.confirmationAlertsButton toggleSelected];
}

- (void) friendRequestsButtonPressed: (id) sender {
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    [self togglePreferenceForKey:@"pref_friendRequests" forButton:view.friendRequestsButton];
}

- (void) togglePreferenceForKey: (NSString*) key forButton: (MPPreferencesButton*) button {
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    dispatch_queue_t prefsQueue = dispatch_queue_create("PreferencesQueue", 0);
    dispatch_async(prefsQueue, ^{
        PFUser* currentUser = [PFUser currentUser];
        NSNumber* prefFriendRequests = [currentUser objectForKey: key];
        BOOL preferenceValue = [prefFriendRequests boolValue];
        [currentUser setObject:[NSNumber numberWithBool:!preferenceValue] forKey:key];
        BOOL success = [currentUser save];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success) {
                [view.menu.subtitleLabel displayMessage:@"Your preferences have been saved." revertAfter:YES withColor:[UIColor MPGreenColor]];
                [button toggleSelected];
            }
            else {
                [view.menu.subtitleLabel displayMessage:@"There was an error saving your preferences. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
            }
        });
    });
}

- (void) confirmationAlertsButtonPressed: (id) sender {
    MPAccountPreferencesView* view = (MPAccountPreferencesView*)self.view;
    [self togglePreferenceForKey:@"pref_confirmation" forButton:view.confirmationAlertsButton];
}

@end
