//
//  MPForgotPasswordViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPForgotPasswordViewController.h"
#import "MPForgotPasswordView.h"
#import "MPErrorAlerter.h"
#import "NSString+MPString.h"
#import <Parse/Parse.h>

@interface MPForgotPasswordViewController ()

@end

@implementation MPForgotPasswordViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPForgotPasswordView alloc] init];
        [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPForgotPasswordView* view = (MPForgotPasswordView*) self.view;
    [view.emailField setDelegate: self];
    [view.resetPasswordButton addTarget:self action:@selector(resetPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.goBackButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
 
    return YES;
}

- (void) resetPasswordButtonPressed: (id) sender {
    MPForgotPasswordView* view = (MPForgotPasswordView*) self.view;
    NSString* emailEntered = view.emailField.text;
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    
    [view.emailField resignFirstResponder];
    
    //First possible error: invalid email
    [alerter checkErrorCondition:(![emailEntered isValidEmail]) withMessage:@"Please enter a valid email address."];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"email" equalTo:emailEntered];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            [alerter checkErrorCondition:true withMessage:@"A query error has occurred and was reported. Sorry about that."];
        }
        else {
            //Check if user exists
            [alerter checkErrorCondition:(objects.count == 0) withMessage:@"No user with that email was found. Please try again."];
            //Should not happen
            [alerter checkErrorCondition:(objects.count > 1) withMessage:@"Multiple users have been detected with this email. This shouldn't happen and has been reported."];
            if(![alerter hasFoundError]) {
                [PFUser requestPasswordResetForEmailInBackground:emailEntered];
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"An email has been sent to reset your password. We'll bring you back to the login screen now." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
                    [self dismissViewControllerAnimated:TRUE completion:nil];
                }];
                [alert addAction: action];
                [self presentViewController:alert animated:TRUE completion:nil];
            }
        }
    }];
}

//Go back button passed: revert last segue
- (IBAction)goBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
