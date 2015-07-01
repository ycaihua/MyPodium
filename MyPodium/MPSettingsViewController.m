//
//  MPSettingsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPErrorAlerter.h"
#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"

#import "MPSettingsView.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPSettingsViewController.h"

#import <Parse/Parse.h>

@interface MPSettingsViewController ()

@end

@implementation MPSettingsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSettingsView* view = [[MPSettingsView alloc] init];
        [view.submitNameButton addTarget:self action:@selector(submitNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view.submitPasswordButton addTarget:self action:@selector(submitPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        self.view = view;
    }
    return self;
}

- (void) keyboardWillShow: (NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    [((MPSettingsView*)self.view) shiftVerticalConstraintsBy: -height];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void) keyboardWillHide: (NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [((MPSettingsView*)self.view) restoreDefaultConstraints];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void) submitNameButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    NSString* name = ((MPSettingsView*)self.view).realNameField.text;
    [alerter checkErrorCondition:(name.length < [MPLimitConstants minRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names need to be at least %d characters.", [MPLimitConstants minRealNameCharacters]]];
    [alerter checkErrorCondition:(name.length > [MPLimitConstants maxRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names can be at most %d characters.", [MPLimitConstants maxRealNameCharacters]]];
    if(![alerter hasFoundError]) {
        dispatch_queue_t saveNameThread = dispatch_queue_create("SaveName", 0);
        dispatch_async(saveNameThread, ^{
            ((MPSettingsView*)self.view).realNameField.text = @"";
            PFUser* currentUser = [PFUser currentUser];
            currentUser[@"realName"] = name;
            BOOL success = [currentUser save];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alerter checkErrorCondition:(!success) withMessage:@"There was a problem saving your name. Please try again later."];
                if(![alerter hasFoundError]) {
                    [((MPSettingsView*)self.view).menu.subtitleLabel displayMessage:@"Your name was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                }
            });
        });
    }
}

- (void) submitPasswordButtonPressed: (id) sender {
    NSString* newPassword = ((MPSettingsView*)self.view).changePasswordField.text;
    NSString* confirmPassword = ((MPSettingsView*)self.view).confirmPasswordField.text;
    NSString* oldPassword = ((MPSettingsView*)self.view).oldPasswordField.text;
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
                        [((MPSettingsView*)self.view).menu.subtitleLabel displayMessage:@"Your password was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                        
                    });
                }
            }
        });
    }

}

@end
