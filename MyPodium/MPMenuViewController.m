//
//  MPMenuViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"
#import "UIColor+MPColor.h"

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"
#import "MPMessagesModel.h"

#import "MPMenuView.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPMenuViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "MPSearchViewController.h"
#import "MPSettingsViewController.h"

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
        [self checkNewNotifications];
    }
    return self;
}

- (void) addMenuActions {
    MPMenuView* view = (MPMenuView*) self.view;
    
    [view.menu.titleButton addTarget:self action:@selector(titleButtonPressedDown:) forControlEvents:UIControlEventTouchDown];
    [view.menu.titleButton addTarget:self action:@selector(titleButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [view.menu.titleButton addTarget:self action:@selector(titleButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    
    [view.menu.sidebarButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.menu.logOutButton addTarget:self action:@selector(logOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [view.menu.hideButton addTarget:self action:@selector(hideIcons:) forControlEvents:UIControlEventTouchUpInside];
    [view.menu.searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.menu.settingsButton addTarget:self action:@selector(settingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) checkNewNotifications {
    dispatch_async(dispatch_queue_create("NewNotificationsQueue", 0), ^{
        NSArray* notifications = @[@([MPTeamsModel countTeamsInvitingUser:[PFUser currentUser]]),
                                   @([MPFriendsModel countIncomingRequestsForUser:[PFUser currentUser]]),
                                   @([MPMessagesModel countNewMessagesForUser:[PFUser currentUser]])];
        int sum = 0;
        for(NSNumber* notificationType in notifications)
            sum += notificationType.integerValue;
        dispatch_async(dispatch_get_main_queue(), ^{
            MPMenuView* view = (MPMenuView*) self.view;
            if(sum > 0)
                [view.menu showNotificationLabelWithInt: sum];
            else
                [view.menu hideNotificationLabel];
        });
    });
    
}

- (void) hideIcons: (id) sender {
    [((MPMenuView*)self.view).menu hideIcons];
}

- (void) titleButtonPressedDown: (id) sender {
    if(self.actionTimer) {
        [self.actionTimer invalidate];
        self.actionTimer = nil;
    }
    self.actionTimer = [NSTimer scheduledTimerWithTimeInterval:[MPMenuViewController iconHoldDuration] target:self selector:@selector(timerDurationCompleted:) userInfo:nil repeats:NO];
}

- (void) titleButtonTouchUpInside: (id) sender {
    [self.actionTimer invalidate];
    self.actionTimer = nil;
    if(self.mm_drawerController && [self.mm_drawerController presentingViewController]) {
        MMDrawerController* container = self.mm_drawerController;
        [MPControllerManager dismissViewController: container];
    }
}

- (void) titleButtonTouchUpOutside: (id) sender {
    [self.actionTimer invalidate];
    self.actionTimer = nil;
}

- (void) timerDurationCompleted: (NSTimer*) timer {
    [((MPMenuView*)self.view).menu showIcons];
    [self.actionTimer invalidate];
    self.actionTimer = nil;
}

- (void) menuButtonPressed: (id) sender {
    MMDrawerController* container = self.mm_drawerController;
    [container toggleDrawerSide:MMDrawerSideLeft animated:true completion:nil];
}

- (void) logOutButtonPressed: (id) sender {
    UIAlertController* logOutConfirmation = [UIAlertController alertControllerWithTitle:@"Log Out" message:@"Are you sure you want to log out?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        [delegate logOut];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [logOutConfirmation addAction: confirmAction];
    [logOutConfirmation addAction: cancelAction];
    [self presentViewController: logOutConfirmation animated: true completion:nil];
}

- (void) searchButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPSearchViewController alloc] init] fromController:self];
}

- (void) settingsButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPSettingsViewController alloc] init] fromController:self];
}

- (void) reloadData {
    if(!self.delegate) return;
    MPMenuView* view = (MPMenuView*)self.view;
    [view startLoading];
    dispatch_async(dispatch_queue_create("LoadOnDismissQueue", 0), ^{
        [self.delegate refreshDataForController: self];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView* table = [self.delegate tableViewToRefreshForController: self];
            if(table) [table reloadData];
            [view finishLoading];
        });
    });
}

- (void) reloadDataWithCompletionBlock: (void (^)()) completion {
    if(!self.delegate) return;
    MPMenuView* view = (MPMenuView*)self.view;
    [view startLoading];
    dispatch_async(dispatch_queue_create("LoadOnDismissQueue", 0), ^{
        [self.delegate refreshDataForController: self];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView* table = [self.delegate tableViewToRefreshForController: self];
            if(table) [table reloadData];
            completion();
        });
    });
}

- (void) performModelUpdate: (BOOL (^)(void)) modelUpdate
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
    withConfirmationMessage: (NSString*) alertMessage {
    MPMenuView* view = (MPMenuView*) self.view;
    UIAlertController* confirmationAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:alertMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("ModelUpdateQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL success = modelUpdate();
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(success) {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [[self.view class] defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                        
                    }];
                }
                else {
                    [self reloadDataWithCompletionBlock:^{
                        view.menu.subtitleLabel.persistentText = [[self.view class] defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                    }];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
        [view.menu.subtitleLabel displayMessage:[[self.view class] defaultSubtitle] revertAfter:false withColor:[UIColor whiteColor]];
        
    }];
    [confirmationAlert addAction: confirmAction];
    [confirmationAlert addAction: cancelAction];
    [self presentViewController: confirmationAlert animated: true completion:nil];
}

- (void) performModelUpdate: (BOOL (^)(void)) modelUpdate
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
    withConfirmationMessage: (NSString*) alertMessage
     shouldShowConfirmation: (BOOL) showConfirmation {
    if(showConfirmation) {
        [self performModelUpdate:modelUpdate withSuccessMessage:successMessage withErrorMessage:errorMessage withConfirmationMessage:alertMessage];
    }
    else {
        [self performModelUpdate:modelUpdate withSuccessMessage:successMessage withErrorMessage:errorMessage];
    }
}

- (void) performModelUpdate: (BOOL (^)(void)) modelUpdate
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage {
    MPMenuView* view = (MPMenuView*) self.view;
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ModelUpdateQueue", 0);
    dispatch_async(backgroundQueue, ^{
        BOOL success = modelUpdate();
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update UI, based on success
            if(success) {
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.persistentText = [[self.view class] defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage: successMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    
                }];
            }
            else {
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.persistentText = [[self.view class] defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                }];
            }
        });
    });
}

- (void) performModelUpdateAndDismissOnSuccess: (BOOL (^)(void)) modelUpdate
                              withErrorMessage: (NSString*) errorMessage {
    MPMenuView* view = (MPMenuView*) self.view;
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ModelUpdateQueue", 0);
    dispatch_async(backgroundQueue, ^{
        BOOL success = modelUpdate();
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update UI, based on success
            if(success) {
                [MPControllerManager dismissViewController: self];
            }
            else {
                [self reloadDataWithCompletionBlock:^{
                    view.menu.subtitleLabel.persistentText = [[self.view class] defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                }];
            }
        });
    });
}


- (BOOL) shouldAutorotate {
    return NO;
}

+ (NSTimeInterval) iconHoldDuration { return 0.75f; }

@end
