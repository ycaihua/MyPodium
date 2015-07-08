//
//  MPMessageReaderViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"
#import "UIColor+MPColor.h"

#import "MPTextField.h"
#import "MPMessageComposerView.h"
#import "MPMessageReaderView.h"
#import "MPBottomEdgeButton.h"

#import "MPMessageReaderViewController.h"
#import "MPMessageComposerViewController.h"

#import <Parse/Parse.h>

@interface MPMessageReaderViewController ()

@end

@implementation MPMessageReaderViewController

- (id) initWithMessage: (PFObject*) message {
    self = [super init];
    if(self) {
        self.message = message;
        MPMessageReaderView* view = [[MPMessageReaderView alloc] init];
        self.view = view;
        [view updateForMessage: message];
        [self markMessageReadInBackground];
        [self disableDeleteButtonIfNecessary];
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPMessageReaderView* view = (MPMessageReaderView*) self.view;
    [view.deleteButton addTarget:self action:@selector(deleteMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.replyButton addTarget:self action:@selector(replyToMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) markMessageReadInBackground {
    PFUser* receiver = self.message[@"receiver"];
    if([receiver.username isEqualToString: [PFUser currentUser].username]) {
        self.message[@"read"] = @YES;
        [self.message saveInBackground];
    }
}

- (void) deleteMessageButtonPressed: (id) sender {
    BOOL displayAlert = [[[PFUser currentUser] objectForKey:@"pref_confirmation"] boolValue];
    if(displayAlert) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to delete this message? This cannot be undone." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            [self deleteMessageAndReturn];
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction: confirmAction];
        [alert addAction: cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [self deleteMessageAndReturn];
    }
}

- (void) replyToMessageButtonPressed: (id) sender {
    MPMessageComposerViewController* destination = [[MPMessageComposerViewController alloc] init];
    MPMessageComposerView* view = (MPMessageComposerView*)destination.view;
    PFUser* messageSender = self.message[@"sender"];
    view.recipientsField.text = messageSender.username;
    [MPControllerManager presentViewController:destination fromController:self];
}

- (void) deleteMessageAndReturn {
    dispatch_async(dispatch_queue_create("DeleteMessageQueue", 0), ^{
        [self.message delete];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MPControllerManager dismissViewController: self];
        });
    });
}

- (void) disableDeleteButtonIfNecessary {
    PFUser* receiver = self.message[@"receiver"];
    if(![receiver.username isEqualToString: [PFUser currentUser].username]) {
        MPBottomEdgeButton* button = ((MPMessageReaderView*)self.view).deleteButton;
        [button disable];
    }
    
}

@end
