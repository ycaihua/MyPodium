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
#import "NSString+MPString.h"

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
    view.realNameField.delegate = self;
    view.changePasswordField.delegate = self;
    view.confirmPasswordField.delegate = self;
    view.oldPasswordField.delegate = self;
    
    [view.submitNameButton addTarget:self action:@selector(submitNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.submitPasswordButton addTarget:self action:@selector(submitPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [view.friendRequestsButton addTarget:self action:@selector(friendRequestsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.confirmationAlertsButton addTarget:self action:@selector(confirmationAlertsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) loadOnDismiss: (id) sender {
    [self initializeUserPreferences];
}

- (void) initializeUserPreferences {
    MPSettingsView* view = (MPSettingsView*)self.view;
    PFUser* currentUser = [PFUser currentUser];
    dispatch_async(dispatch_queue_create("FetchUserQueue", 0), ^{
        [currentUser fetch];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(currentUser[@"realName"])
                view.realNameField.text = currentUser[@"realName"];
            
            NSNumber* prefFriendRequests = [currentUser objectForKey:@"pref_friendRequests"];
            if([prefFriendRequests isEqual: [NSNumber numberWithBool:FALSE]]) [view.friendRequestsButton toggleSelected];
            
            NSNumber* prefConfirmations = [currentUser objectForKey:@"pref_confirmation"];
            if([prefConfirmations isEqual: [NSNumber numberWithBool:FALSE]]) [view.confirmationAlertsButton toggleSelected];
            
            NSString* email = currentUser[@"email"];
            BOOL emailVerified = [currentUser[@"emailVerified"] boolValue];
            if(emailVerified) {
                [view setEmailVerified:email];
                [view.emailVerifiedButton addTarget:self action:@selector(changeEmail:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
                [view setEmailUnverified:email];
                [view.emailVerifiedButton addTarget:self action:@selector(verifyOrChangeEmail:) forControlEvents:UIControlEventTouchUpInside];
        });
    });
}

- (void) changeEmail: (id) sender {
    PFUser* currentUser = [PFUser currentUser];
    MPSettingsView* view = (MPSettingsView*) self.view;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Email" message:@"Enter your new email below." preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController* alertReference = alert;
    UIAlertAction* submitAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
        NSString* emailEntered = alertReference.textFields[0].text;
        [alerter checkErrorCondition:![emailEntered isValidEmail] withMessage:@"You didn't enter a valid email address."];
        [alerter checkErrorCondition:[emailEntered isEqualToString:currentUser.email] withMessage:@"The email you entered is the one we already have on file for you."];
        if(![alerter hasFoundError]) {
            dispatch_async(dispatch_queue_create("ChangeEmailQueue", 0), ^{
                [currentUser setEmail: emailEntered];
                BOOL success = [currentUser save];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(success) {
                        [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:@"You changed your email to %@. A verification email has been sent.", emailEntered] revertAfter:YES withColor:[UIColor MPGreenColor]];
                        [self initializeUserPreferences];
                    }
                    else
                        [view.menu.subtitleLabel displayMessage:@"There was an error changing your email. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
                });
            });
        }
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction: submitAction];
    [alert addAction: cancelAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"email address";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    [self presentViewController: alert animated:YES completion:nil];
}

- (void) verifyOrChangeEmail: (id) sender {
    MPSettingsView* view = (MPSettingsView*) self.view;
    PFUser* currentUser = [PFUser currentUser];
    NSString* email = currentUser[@"email"];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Email" message:[NSString stringWithFormat:@"Please choose whether you would like to resend the verification to your current email (%@), change your email, or neither.", email] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* verifyAction = [UIAlertAction actionWithTitle:@"Verify Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        dispatch_async(dispatch_queue_create("VerifyEmailQueue", 0), ^{
            //Parse won't resend verification email unless a change has occurred in the
            //email field.
            [currentUser setEmail: @""];
            BOOL success = [currentUser save];
            if(success) {
                [currentUser setEmail: email];
                success = [currentUser save];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success) {
                    [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:@"A verification email has been sent to %@.", email] revertAfter:YES withColor:[UIColor MPGreenColor]];
                    [self initializeUserPreferences];
                }
               else
                    [view.menu.subtitleLabel displayMessage:@"There was an error sending the verification. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
            });
        });
    }];
    UIAlertAction* changeAction = [UIAlertAction actionWithTitle:@"Change Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [self changeEmail: self];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction: verifyAction];
    [alert addAction: changeAction];
    [alert addAction: cancelAction];
    [self presentViewController: alert animated:YES completion:nil];
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

- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    MPSettingsView* view = (MPSettingsView*) self.view;
    CGFloat frameCenter = view.center.y;
    CGFloat fieldCenter = textField.center.y;
    CGPoint currentOffset = view.preferencesScrollView.contentOffset;
    CGPoint point = CGPointMake(currentOffset.x, currentOffset.y + (fieldCenter - frameCenter));
    [view.preferencesScrollView setContentOffset:point animated:YES];
}

- (void) scrollViewEditingFinished:(UITextField*)textField
{
    MPSettingsView* view = (MPSettingsView*) self.view;
    CGPoint point = CGPointMake(0, 0);
    [view.preferencesScrollView setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.text.length == 0) {
        [textField resignFirstResponder];
        [self scrollViewEditingFinished:textField];
        return YES;
    }
    MPSettingsView* view = (MPSettingsView*)self.view;
    if([textField isEqual: view.realNameField]) {
        [textField resignFirstResponder];
        if(textField.text.length > 0)
            [self submitNameButtonPressed: self];
    }
    else if([textField isEqual: view.changePasswordField]) {
        [view.confirmPasswordField becomeFirstResponder];
        [self scrollViewAdaptToStartEditingTextField: view.confirmPasswordField];
    }
    else if([textField isEqual: view.confirmPasswordField]) {
        [view.oldPasswordField becomeFirstResponder];
        [self scrollViewAdaptToStartEditingTextField: view.oldPasswordField];
    }
    else {
        [textField resignFirstResponder];
        [self submitPasswordButtonPressed: self];
    }
    return YES;
}

@end
