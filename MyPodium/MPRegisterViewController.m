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

#import "MPRegisterView.h"
#import "MPTextField.h"
#import "MPLabel.h"

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
    [view.titleLabel displayMessage:@"LOADING..." revertAfter:NO];
    [self.view endEditing:YES];
    NSString* username = view.usernameField.text;
    NSString* usernameSearchable = username.lowercaseString;
    NSString* password = view.passwordField.text;
    NSString* email = view.emailField.text;
    NSString* emailSearchable = email.lowercaseString;
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    
    //Potential username errors: length boundaries, already
    //in use, illegal characters
    [alerter checkErrorCondition:(username.length < [MPLimitConstants minUsernameCharacters]) withMessage:[NSString stringWithFormat:@"Your username must be at least %d characters long.",
                                                                                                           [MPLimitConstants minUsernameCharacters]]];
    [alerter checkErrorCondition:(username.length > [MPLimitConstants maxUsernameCharacters]) withMessage:[NSString stringWithFormat:@"Your username cannot be longer than %d characters.",
                                                                                                           [MPLimitConstants maxUsernameCharacters]]];
    [alerter checkErrorCondition:!([username isValidUsername]) withMessage:@"Usernames must be alphanumeric (just letters and numbers)."];
    
    //Potential password errors: length boundaries
    [alerter checkErrorCondition:(password.length < [MPLimitConstants minUsernameCharacters]) withMessage:[NSString stringWithFormat:@"Your password must be at least %d characters long.",
                                                                                                           [MPLimitConstants minPasswordCharacters]]];
    [alerter checkErrorCondition:(password.length > [MPLimitConstants maxUsernameCharacters]) withMessage:[NSString stringWithFormat:@"Your password cannot be longer than %d characters.",
                                                                                                           [MPLimitConstants maxPasswordCharacters]]];
    
    //Potential email errors: invalid email, already in use
    [alerter checkErrorCondition:!([email isValidEmail]) withMessage:@"You didn't enter a valid email."];
    
    //No need to query if already found error
    if([alerter hasFoundError]) {
        [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
        return;
    }
    
    dispatch_queue_t registerQueue = dispatch_queue_create("RegisterQueue", 0);
    dispatch_async(registerQueue, ^{
    //All query-related checks
    PFQuery *nameQuery = [PFUser query];
    [nameQuery whereKey:@"username_searchable" equalTo:usernameSearchable];
    [nameQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //Check username availability
            [alerter checkErrorCondition:(objects.count > 0) withMessage:@"That username is already in use. Please try another."];
            if([alerter hasFoundError])
                [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
            PFQuery *emailQuery = [PFUser query];
            [emailQuery whereKey:@"email_searchable" equalTo:emailSearchable];
            [emailQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    //Check email availability
                    [alerter checkErrorCondition:(objects.count > 0) withMessage:@"That email is already in use: are you sure you haven't already registered?"];
                    if([alerter hasFoundError])
                        [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
                    //Go back to main queue
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(![alerter hasFoundError]) {
                            PFUser *user = [PFUser user];
                            user.username = username;
                            user[@"username_searchable"] = usernameSearchable;
                            user.password = password;
                            user.email = email;
                            user[@"email_searchable"] = emailSearchable;
                            user[@"pref_friendRequests"] = [NSNumber numberWithBool:YES];
                            user[@"pref_confirmation"] = [NSNumber numberWithBool:YES];
                            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (error) {
                                    [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
                                    [alerter checkErrorCondition:true withMessage:@"An error occurred. Please try again later."];
                                }
                                else {
                                    [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
                                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Your account has been registered. We'll bring you back to the login screen now." preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
                                        [self dismissViewControllerAnimated:TRUE completion:nil];
                                    }];
                                    [alert addAction: action];
                                    [self presentViewController:alert animated:TRUE completion:nil];
                                }
                            }];
                        }
                    });
                }
                else {
                    [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
                    [alerter checkErrorCondition:true withMessage:@"Server error: please try again later."];
                }
            }];
        }else{
            [view.titleLabel displayMessage:@"REGISTER" revertAfter:NO];
            [alerter checkErrorCondition:true withMessage:@"Server error: please try again later."];
        }
    }];});
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

//This controller shouldn't support landscape
- (BOOL) shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
