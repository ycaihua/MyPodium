//
//  MPAccountDetailsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPErrorAlerter.h"
#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"

#import "MPAccountDetailsView.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPAccountDetailsViewController.h"

#import <Parse/Parse.h>

@interface MPAccountDetailsViewController ()

@end

@implementation MPAccountDetailsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPAccountDetailsView* view = [[MPAccountDetailsView alloc] init];
        [view.submitNameButton addTarget:self action:@selector(submitNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view.submitPasswordButton addTarget:self action:@selector(submitPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        for(UITextField* textField in @[view.realNameField, view.changePasswordField, view.confirmPasswordField, view.oldPasswordField]) {
            [textField setDelegate: self];
        }
        self.view = view;
    }
    return self;
}

- (void) keyboardWillShow: (NSNotification *)notification {
    MPAccountDetailsView* view = ((MPAccountDetailsView*)self.view);
    UITextField* responder;
    for(UITextField* textfield in @[view.realNameField, view.changePasswordField, view.confirmPasswordField, view.oldPasswordField]) {
        if([textfield isFirstResponder]) {
            responder = textfield;
            break;
        }
    }
    
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    self.keyboardHeight = height;
    
    [self shiftConstraintToFocusTextField: responder animationDuration: animationDuration];
}

- (void) shiftConstraintToFocusTextField: (UITextField*) textField animationDuration: (NSTimeInterval) animationDuration {
    CGFloat fieldBottom = textField.frame.origin.y + textField.frame.size.height;
    //Note: here we assume self.keyboardHeight has to be initialized, because a keyboard must have been
    //shown prior to this method call
    CGFloat shiftAmount = (self.view.frame.size.height - self.keyboardHeight - fieldBottom - 5);
    
    if(shiftAmount >= 0) {
        [((MPAccountDetailsView*)self.view) restoreDefaultConstraints];
        return;
    }
    
    [((MPAccountDetailsView*)self.view) shiftVerticalConstraintsBy: shiftAmount];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void) keyboardWillHide: (NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [((MPAccountDetailsView*)self.view) restoreDefaultConstraints];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void) submitNameButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    NSString* name = ((MPAccountDetailsView*)self.view).realNameField.text;
    [alerter checkErrorCondition:(name.length < [MPLimitConstants minRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names need to be at least %d characters.", [MPLimitConstants minRealNameCharacters]]];
    [alerter checkErrorCondition:(name.length > [MPLimitConstants maxRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names can be at most %d characters.", [MPLimitConstants maxRealNameCharacters]]];
    if(![alerter hasFoundError]) {
        dispatch_queue_t saveNameThread = dispatch_queue_create("SaveName", 0);
        dispatch_async(saveNameThread, ^{
            PFUser* currentUser = [PFUser currentUser];
            currentUser[@"realName"] = name;
            BOOL success = [currentUser save];
            dispatch_async(dispatch_get_main_queue(), ^{
                ((MPAccountDetailsView*)self.view).realNameField.text = @"";
                [alerter checkErrorCondition:(!success) withMessage:@"There was a problem saving your name. Please try again later."];
                if(![alerter hasFoundError]) {
                    [((MPAccountDetailsView*)self.view).menu.subtitleLabel displayMessage:@"Your name was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                }
            });
        });
    }
}

- (void) submitPasswordButtonPressed: (id) sender {
    NSString* newPassword = ((MPAccountDetailsView*)self.view).changePasswordField.text;
    NSString* confirmPassword = ((MPAccountDetailsView*)self.view).confirmPasswordField.text;
    NSString* oldPassword = ((MPAccountDetailsView*)self.view).oldPasswordField.text;
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
                        [((MPAccountDetailsView*)self.view).menu.subtitleLabel displayMessage:@"Your password was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                    });
                }
            }
        });
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    MPAccountDetailsView* view = (MPAccountDetailsView*)self.view;
    if([textField isEqual: view.realNameField]) {
        [textField resignFirstResponder];
        if(textField.text.length > 0)
            [self submitNameButtonPressed: self];
    }
    else if([textField isEqual: view.changePasswordField]) {
        [view.confirmPasswordField becomeFirstResponder];
        [self shiftConstraintToFocusTextField: view.confirmPasswordField animationDuration:0.5f];
    }
    else if([textField isEqual: view.confirmPasswordField]) {
        [view.oldPasswordField becomeFirstResponder];
        [self shiftConstraintToFocusTextField: view.oldPasswordField animationDuration:0.5f];
    }
    else {
        [textField resignFirstResponder];
        [self submitPasswordButtonPressed: self];
    }
    return YES;
}

@end
