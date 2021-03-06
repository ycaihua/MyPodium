//
//  MPLoginViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPErrorAlerter.h"

#import "MPLoginView.h"

#import "MPLoginViewController.h"
#import "MPRegisterViewController.h"
#import "MPForgotPasswordViewController.h"
#import "MPHelpViewController.h"
#import "MMDrawerController.h"

#import "AppDelegate.h"
#import "Reachability.h"
#import <Parse/Parse.h>

@interface MPLoginViewController ()

@end

@implementation MPLoginViewController

- (id) init {
    self = [super init];
    if(self) {
        self.view = [[MPLoginView alloc] init];
        [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPLoginView* view = (MPLoginView*)self.view;
    [view.logoButton addTarget:self
                        action:@selector(logoButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [view.loginButton addTarget:self
                         action:@selector(loginButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    [view.registerButton addTarget:self
                            action:@selector(registerButtonPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
    [view.forgotPasswordButton addTarget:self
                                  action:@selector(forgotPasswordButtonPressed:)
                        forControlEvents:UIControlEventTouchUpInside];
    [view.usernameField setDelegate:self];
    [view.passwordField setDelegate:self];
}

- (void) logoButtonPressed: (id) sender {
    MPLoginView* view = (MPLoginView*)self.view;
    [view.logoButton setImage:[view.logoButton imageForState:UIControlStateHighlighted] forState:UIControlStateNormal];
    [view animateLogoMovement];
    [self performSelector:@selector(transitionToHelp:) withObject:self afterDelay:0.8];
}

- (void) transitionToHelp: (id) sender {
    [self presentViewController:[[MPHelpViewController alloc] init] animated:NO completion:nil];
}

- (void) loginButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    MPLoginView* view = (MPLoginView*)self.view;
    
    [alerter checkErrorCondition:(view.usernameField.text.length == 0) withMessage:@"Please enter a username."];
    [alerter checkErrorCondition:(view.passwordField.text.length == 0) withMessage:@"Please enter a password."];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    [alerter checkErrorCondition:(networkStatus==NotReachable) withMessage:@"No network connection was found. Please establish a connection and try again."];
    
    if([alerter hasFoundError]) return;
    
    [PFUser logInWithUsernameInBackground:view.usernameField.text
                                 password:view.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
        if (user) {
            [MPLoginViewController login];
        } else {
            [alerter checkErrorCondition:true withMessage:@"We couldn't authenticate you. Please check over your login information and make sure you have a network connection."];
        }
    }];
}

+ (void) login {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    MMDrawerController* target = [AppDelegate makeLoggedInRootController];
    delegate.window.rootViewController = target;
    [UIView transitionWithView:delegate.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ delegate.window.rootViewController = target; }
                    completion:nil];
}

- (void) registerButtonPressed: (id) sender {
    MPRegisterViewController* destination = [[MPRegisterViewController alloc] init];
    [self presentViewController:destination animated:TRUE completion:nil];
}

- (void) forgotPasswordButtonPressed: (id) sender {
    MPForgotPasswordViewController* destination = [[MPForgotPasswordViewController alloc] init];
    [self presentViewController:destination animated:TRUE completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    MPLoginView* view = (MPLoginView*)self.view;
    
    if([textField isEqual:view.usernameField] &&
       (view.passwordField.text.length == 0)) {
        [view.passwordField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self performSelector:@selector(loginButtonPressed:) withObject:self];
    }
    return YES;
}

//This controller shouldn't support landscape
- (BOOL) shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
@end
