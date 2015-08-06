//
//  MPRegisterViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "NSString+MPString.h"
#import "MPErrorAlerter.h"
#import "MPLimitConstants.h"

#import "MPGlobalModel.h"

#import "MPFormView.h"
#import "MPRegisterUsernameView.h"
#import "MPRegisterPasswordView.h"
#import "MPRegisterEmailView.h"
#import "MPRegisterDisplayNameView.h"
#import "MPRegisterView.h"
#import "MPTextField.h"
#import "MPLabel.h"
#import "MPBottomEdgeButton.h"

#import "MPRegisterViewController.h"

#import <Parse/Parse.h>

@interface MPRegisterViewController ()

@end

@implementation MPRegisterViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPRegisterView alloc] init];
        [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPRegisterView* view = (MPRegisterView*) self.view;
    
    [view.form.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.form.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.usernameView = (MPRegisterUsernameView*)[view.form slideWithClass: [MPRegisterUsernameView class]];
    self.usernameView.usernameField.delegate = self;
    
    self.passwordView = (MPRegisterPasswordView*)[view.form slideWithClass:[MPRegisterPasswordView class]];
    self.passwordView.passwordField.delegate = self;
    self.passwordView.confirmPasswordField.delegate = self;
    
    self.emailView = (MPRegisterEmailView*)[view.form slideWithClass:[MPRegisterEmailView class]];
    self.emailView.emailField.delegate = self;
    
    self.nameView = (MPRegisterDisplayNameView*)[view.form slideWithClass:[MPRegisterDisplayNameView class]];
    self.nameView.nameField.delegate = self;
}

- (void) nextButtonPressed: (id) sender {
    MPRegisterView* view = (MPRegisterView*) self.view;
    UIView* focusedSubview = [view.form currentSlide];
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    
    dispatch_async(dispatch_queue_create("CheckErrorsQueue", 0), ^{
        BOOL errorsFound = NO;
        if([focusedSubview isKindOfClass:[MPRegisterUsernameView class]]) {
            NSString* username = self.usernameView.usernameField.text;
            [alerter checkErrorCondition:!([username isValidUsername]) withMessage:@"You didn't enter a valid username. Only letters, numbers and underscores are allowed."];
            [alerter checkErrorCondition:(username.length < [MPLimitConstants minUsernameCharacters]) withMessage:[NSString stringWithFormat:@"Usernames must be at least %d characters long.", [MPLimitConstants minUsernameCharacters]]];
            [alerter checkErrorCondition:(username.length > [MPLimitConstants maxUsernameCharacters]) withMessage:[NSString stringWithFormat:@"Usernames can be at most %d characters long.", [MPLimitConstants maxUsernameCharacters]]];
            [alerter checkErrorCondition:[MPGlobalModel usernameInUse:username] withMessage:@"A user with this username already exists. Please try another."];
        }
        else if([focusedSubview isKindOfClass: [MPRegisterPasswordView class]]) {
            NSString* password = self.passwordView.passwordField.text;
            NSString* confirmPassword = self.passwordView.confirmPasswordField.text;
            [alerter checkErrorCondition:(password.length < [MPLimitConstants minPasswordCharacters]) withMessage:
             [NSString stringWithFormat:@"Passwords must be at least %d characters long.", [MPLimitConstants minPasswordCharacters]]];
            [alerter checkErrorCondition:(password.length > [MPLimitConstants maxPasswordCharacters]) withMessage:[NSString stringWithFormat:@"Passwords can be at most %d characters long.", [MPLimitConstants maxPasswordCharacters]]];
            [alerter checkErrorCondition:!([password isEqualToString: confirmPassword]) withMessage:@"Your two password entries did not match."];
        }
        else if([focusedSubview isKindOfClass: [MPRegisterEmailView class]]) {
            NSString* email = self.emailView.emailField.text;
            [alerter checkErrorCondition:!([email isValidEmail]) withMessage: @"You didn't enter a valid email."];
        }
        else if([focusedSubview isKindOfClass: [MPRegisterDisplayNameView class]]) {
            NSString* realName = self.nameView.nameField.text;
            [alerter checkErrorCondition:(realName.length > [MPLimitConstants maxRealNameCharacters]) withMessage: [NSString stringWithFormat:@"Display names can be at most %d characters long.", [MPLimitConstants maxRealNameCharacters]]];
        }
        errorsFound = [alerter hasFoundError];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!errorsFound) {
                if(view.form.slideViewIndex == view.form.slideViews.count - 1) {
                    [self registerAccount];
                }
                else {
                    [view.form advanceToNextSlide];
                }
            }
        });
    });
}

- (void) registerAccount {
    NSString* username = self.usernameView.usernameField.text;
    NSString* password = self.passwordView.passwordField.text;
    NSString* email = self.emailView.emailField.text;
    NSString* realName = self.nameView.nameField.text;
    
    PFUser* newUser = [PFUser user];
    
    newUser.username = username;
    newUser[@"username_searchable"] = username.lowercaseString;
    
    newUser.password = password;
    
    newUser.email = email;
    newUser[@"email_searchable"] = email.lowercaseString;
    
    if(realName.length > 0) {
        newUser[@"realName"] = realName;
        newUser[@"realName_searchable"] = realName.lowercaseString;
    }
    
    newUser[@"pref_confirmation"] = [NSNumber numberWithBool:YES];
    newUser[@"pref_friendRequests"] = [NSNumber numberWithBool:YES];
    
    dispatch_async(dispatch_queue_create("SignUpQueue", 0), ^{
        BOOL success = [newUser signUp];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success) {
                UIAlertController* success = [UIAlertController alertControllerWithTitle:@"Success" message:@"You have signed up for a MyPodium account. You will now be redirected to the login page." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* successAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [success addAction: successAction];
                [self presentViewController:success animated:YES completion:nil];
            }
            else {
                MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
                [alerter checkErrorCondition:YES withMessage:@"There was an error signing up your account. Please try again later."];
            }
        });
    });
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    MPRegisterView* view = (MPRegisterView*) self.view;
    MPRegisterPasswordView* passwordView = (MPRegisterPasswordView*)[view.form slideWithClass:[MPRegisterPasswordView class]];
    if([textField isEqual:passwordView.passwordField]) {
        [passwordView.confirmPasswordField becomeFirstResponder];
    }
    else {
        [self nextButtonPressed: self];
    }
    return YES;
}

- (void) previousButtonPressed: (id) sender {
    MPRegisterView* view = (MPRegisterView*) self.view;
    if(view.form.slideViewIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [view.form returnToLastSlide];
    }
}

//This controller shouldn't support landscape
- (BOOL) shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
