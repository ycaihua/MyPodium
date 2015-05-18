//
//  MPLoginViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLoginViewController.h"
#import "MPLoginView.h"
#import "MPErrorAlerter.h"
#import "MPRegisterViewController.h"
#import "MPForgotPasswordViewController.h"
#import "MPMenuViewController.h"
#import "MPSidebarViewController.h"
#import "MMDrawerController.h"
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

- (void) loginButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    MPLoginView* view = (MPLoginView*)self.view;
    
    [alerter checkErrorCondition:(view.usernameField.text.length == 0) withMessage:@"Please enter a username."];
    [alerter checkErrorCondition:(view.passwordField.text.length == 0) withMessage:@"Please enter a password."];
    if([alerter hasFoundError]) return;
    
    [PFUser logInWithUsernameInBackground:view.usernameField.text
                                 password:view.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
        if (user) {
            [self login];
        } else {
            [alerter checkErrorCondition:true withMessage:@"Your credentials didn't seem to work. Please try again or request a password reset if you don't remember your information."];
        }
    }];
}

- (void) login {
    MPMenuViewController *center = [[MPMenuViewController alloc] initWithTitle:[PFUser currentUser].username.uppercaseString subtitle:@"friends"];
    
    //Will need to be the menu
    MPSidebarViewController *left = [[MPSidebarViewController alloc] init];
    
    MMDrawerController* drawer = [[MMDrawerController alloc] initWithCenterViewController:center leftDrawerViewController:left];
    
    //Actions have to be added to MPMenuViewController after it has
    //a drawer container (above)
    [center addControlActions];
    
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeCustom;
    drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    //Custom gesture to close sidebar on any touch of center
    [drawer setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        BOOL shouldRecognizeTouch = NO;
        if(drawerController.openSide == MMDrawerSideLeft &&
           ([gesture isKindOfClass:[UITapGestureRecognizer class]] ||
            [gesture isKindOfClass:[UIPanGestureRecognizer class]])){
               UIView * customView = [drawerController.centerViewController view];
               CGPoint location = [touch locationInView:customView];
               shouldRecognizeTouch = (CGRectContainsPoint(customView.bounds, location));
           }
        return shouldRecognizeTouch;
    }];
    
    [self presentViewController:drawer animated:YES completion: nil];
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
@end
