//
//  MPMenuViewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPDataLoader.h"

@interface MPMenuViewController : UIViewController

- (void) addMenuActions;

@property NSTimer* actionTimer;
@property id<MPDataLoader> delegate;

- (void) checkNewNotifications;
- (void) reloadData;
- (void) reloadDataWithCompletionBlock: (void (^)()) completion;

- (void) performModelUpdate: (BOOL (^)(void)) modelUpdate
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
    withConfirmationMessage: (NSString*) alertMessage;
- (void) performModelUpdate: (BOOL (^)(void)) modelUpdate
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage;
- (void) performModelUpdateAndDismissOnSuccess: (BOOL (^)(void)) modelUpdate
                              withErrorMessage: (NSString*) errorMessage;
- (void) performModelUpdate: (BOOL (^)(void)) modelUpdate
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
    withConfirmationMessage: (NSString*) alertMessage
     shouldShowConfirmation: (BOOL) showConfirmation;

@end
