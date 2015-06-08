//
//  MPRegisterViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "NSString+MPString.h"
#import "MPErrorAlerter.h"

#import "MPRegisterView.h"
#import "MPTextField.h"

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
    [view.registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.goBackButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.usernameField setDelegate: self];
    [view.passwordField setDelegate: self];
    [view.emailField setDelegate: self];
}

- (void) registerButtonPressed: (id) sender {
    MPRegisterView* view = (MPRegisterView*) self.view;
    [self.view performSelector:@selector(responderButtonPressed:) withObject:self];
    NSString* username = view.usernameField.text.lowercaseString;
    NSString* password = view.passwordField.text;
    NSString* email = view.emailField.text.lowercaseString;
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    PFQuery *nameQuery = [PFUser query];
    PFQuery *emailQuery = [PFUser query];
    
    //Potential username errors: length boundaries, already
    //in use, illegal characters
    [alerter checkErrorCondition:(username.length < 4) withMessage:@"Your username must be at least 4 characters long."];
    [alerter checkErrorCondition:(username.length > 12) withMessage:@"Your username cannot be longer than 12 characters."];
    [alerter checkErrorCondition:!([username isValidUsername]) withMessage:@"Usernames must be alphanumeric (just letters and numbers)."];
    
    //We need synchronous queries (which might be slow),
    //so if we already have an error, don't do the query
    if([alerter hasFoundError]) return;
    
    [nameQuery whereKey:@"username" equalTo:username];
    NSArray* usersWithUsername = [nameQuery findObjects];
    [alerter checkErrorCondition:(usersWithUsername.count > 0) withMessage:@"That username is already in use. Please try another."];
    
    //Potential password errors: length boundaries
    [alerter checkErrorCondition:(password.length < 4) withMessage:@"Your password must be at least 4 characters long."];
    [alerter checkErrorCondition:(password.length > 16) withMessage:@"Your password cannot be longer than 16 characters."];
    
    //Potential email errors: invalid email, already in use
    [alerter checkErrorCondition:!([email isValidEmail]) withMessage:@"You didn't enter a valid email."];
    
    if([alerter hasFoundError]) return;
    
    [emailQuery whereKey:@"email" equalTo:email];
    NSArray* usersWithEmail = [emailQuery findObjects];
    [alerter checkErrorCondition:(usersWithEmail.count > 0) withMessage:@"That email is already in use: are you sure you haven't already registered?"];
    
    if(![alerter hasFoundError]) {
        PFUser *user = [PFUser user];
        user.username = username;
        user.password = password;
        user.email = email;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                [alerter checkErrorCondition:true withMessage:@"A query error has occurred and was reported. Sorry about that."];
            }
            else {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Your account has been registered. We'll bring you back to the login screen now." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
                    [self dismissViewControllerAnimated:TRUE completion:nil];
                }];
                [alert addAction: action];
                [self presentViewController:alert animated:TRUE completion:nil];
            }
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    MPRegisterView* view = (MPRegisterView*) self.view;
    if([textField isEqual:view.usernameField]) {
        [view.passwordField becomeFirstResponder];
    }
    else if([textField isEqual: view.passwordField]) {
        [view.emailField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self performSelector:@selector(registerButtonPressed:) withObject:self];
    }
    return YES;
}

- (void) goBackButtonPressed: (id) sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
