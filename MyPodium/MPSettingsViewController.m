//
//  MPSettingsView.m
//  MyPodium
//
//  Created by Connor Neville on 7/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPErrorAlerter.h"
#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"

#import "MPSettingsView.h"
#import "MPSettingsViewController.h"
#import "MPPreferencesButton.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"
#import "MPSettingsScrollView.h"

#import <Parse/Parse.h>

@interface MPSettingsView ()

@end

@implementation MPSettingsViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPSettingsView alloc] init];
        [self makeControlActions];
        [self initializeUserPreferences];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    MPSettingsView* view = (MPSettingsView*) self.view;
    [view.preferencesScrollView addConstraint:[NSLayoutConstraint constraintWithItem:view.preferencesContentView
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view.preferencesScrollView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0]];
}

- (void) makeControlActions {
    MPSettingsView* view = (MPSettingsView*)self.view;
    [view.friendRequestsButton addTarget:self action:@selector(friendRequestsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.confirmationAlertsButton addTarget:self action:@selector(confirmationAlertsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) initializeUserPreferences {
    MPSettingsView* view = (MPSettingsView*)self.view;
    PFUser* currentUser = [PFUser currentUser];
    
    NSNumber* prefFriendRequests = [currentUser objectForKey:@"pref_friendRequests"];
    if([prefFriendRequests isEqual: [NSNumber numberWithBool:FALSE]]) [view.friendRequestsButton toggleSelected];
    
    NSNumber* prefConfirmations = [currentUser objectForKey:@"pref_confirmation"];
    if([prefConfirmations isEqual: [NSNumber numberWithBool:FALSE]]) [view.confirmationAlertsButton toggleSelected];
}

- (void) friendRequestsButtonPressed: (id) sender {
    MPSettingsView* view = (MPSettingsView*)self.view;
    [self togglePreferenceForKey:@"pref_friendRequests" forButton:view.friendRequestsButton];
}

- (void) togglePreferenceForKey: (NSString*) key forButton: (MPPreferencesButton*) button {
    MPSettingsView* view = (MPSettingsView*)self.view;
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
    MPSettingsView* view = (MPSettingsView*)self.view;
    [self togglePreferenceForKey:@"pref_confirmation" forButton:view.confirmationAlertsButton];
}
- (void) submitNameButtonPressed: (id) sender {
    MPSettingsView* view = (MPSettingsView*)self.view;
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    NSString* name = view.realNameField.text;
    [alerter checkErrorCondition:(name.length < [MPLimitConstants minRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names need to be at least %d characters.", [MPLimitConstants minRealNameCharacters]]];
    [alerter checkErrorCondition:(name.length > [MPLimitConstants maxRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names can be at most %d characters.", [MPLimitConstants maxRealNameCharacters]]];
    if(![alerter hasFoundError]) {
        dispatch_queue_t saveNameThread = dispatch_queue_create("SaveName", 0);
        dispatch_async(saveNameThread, ^{
            PFUser* currentUser = [PFUser currentUser];
            currentUser[@"realName"] = name;
            BOOL success = [currentUser save];
            dispatch_async(dispatch_get_main_queue(), ^{
                ((MPSettingsView*)self.view).realNameField.text = @"";
                [alerter checkErrorCondition:(!success) withMessage:@"There was a problem saving your name. Please try again later."];
                if(![alerter hasFoundError]) {
                    [view.menu.subtitleLabel displayMessage:@"Your name was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                }
            });
        });
    }
}

- (void) submitPasswordButtonPressed: (id) sender {
    MPSettingsView* view = (MPSettingsView*) self.view;
    
    NSString* newPassword = view.changePasswordField.text;
    NSString* confirmPassword = view.confirmPasswordField.text;
    NSString* oldPassword = view.oldPasswordField.text;
    
    view.changePasswordField.text = @"";
    view.confirmPasswordField.text = @"";
    view.oldPasswordField.text = @"";
    
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    
    [alerter checkErrorCondition:![newPassword isEqualToString: confirmPassword] withMessage:@"Your two password entries did not match."];
    [alerter checkErrorCondition:(newPassword.length < [MPLimitConstants minPasswordCharacters]) withMessage:[NSString stringWithFormat:@"Passwords must be at least %d characters long.", [MPLimitConstants minPasswordCharacters]]];
    [alerter checkErrorCondition:(newPassword.length > [MPLimitConstants maxPasswordCharacters]) withMessage:[NSString stringWithFormat:@"Passwords can be at most %d characters long.", [MPLimitConstants maxPasswordCharacters]]];
    
    if(![alerter hasFoundError]) {
        dispatch_queue_t saveNameThread = dispatch_queue_create("SaveName", 0);
        dispatch_async(saveNameThread, ^{
            id success = [PFUser logInWithUsername:[PFUser currentUser].username password:oldPassword];
            [alerter checkErrorCondition:!(success) withMessage:@"Verification failed. Check your entry for your old password."];
            if(![alerter hasFoundError]) {
                PFUser* currentUser = [PFUser currentUser];
                currentUser[@"password"] = newPassword;
                [alerter checkErrorCondition:![currentUser save] withMessage:@"There was an error saving your password. Please try again later."];
                if(![alerter hasFoundError]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [view.menu.subtitleLabel displayMessage:@"Your password was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                    });
                }
            }
        });
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    MPSettingsView* view = (MPSettingsView*)self.view;
    if([textField isEqual: view.realNameField]) {
        [textField resignFirstResponder];
        if(textField.text.length > 0)
            [self submitNameButtonPressed: self];
    }
    else if([textField isEqual: view.changePasswordField]) {
        [view.confirmPasswordField becomeFirstResponder];
    }
    else if([textField isEqual: view.confirmPasswordField]) {
        [view.oldPasswordField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self submitPasswordButtonPressed: self];
    }
    return YES;
}

@end
