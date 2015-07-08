//
//  MPMessageComposerViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "MPControllerManager.h"
#import "MPLimitConstants.h"

#import "MPFriendsModel.h"

#import "MPMenu.h"
#import "MPLabel.h"
#import "MPTextField.h"
#import "MPBottomEdgeButton.h"
#import "MPMessageComposerView.h"

#import "MPMessageComposerViewController.h"

@interface MPMessageComposerViewController ()

@end

@implementation MPMessageComposerViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMessageComposerView* view = [[MPMessageComposerView alloc] init];
        self.view = view;
        
        view.recipientsField.delegate = self;
        view.titleField.delegate = self;
        view.bodyView.delegate = self;
        
        [self makeControlActions];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void) makeControlActions {
    MPMessageComposerView* view = ((MPMessageComposerView*)self.view);
    
    [view.titleField addTarget:self
                        action:@selector(titleFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
    [view.sendButton addTarget:self
                        action:@selector(sendButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [view.cancelButton addTarget:self
                          action:@selector(cancelButtonPressed:)
                forControlEvents:UIControlEventTouchUpInside];
}

- (void) cancelButtonPressed: (id) sender {
    MPMessageComposerView* view = ((MPMessageComposerView*)self.view);
    if([view.bodyView isFirstResponder]) {
        [view.bodyView resignFirstResponder];
        return;
    }
    [MPControllerManager dismissViewController: self];
}

- (void) sendButtonPressed: (id) sender {
    MPMessageComposerView* view = ((MPMessageComposerView*)self.view);
    for(UIControl* control in @[view.recipientsField, view.titleField, view.bodyView]) {
        if([control isFirstResponder]) {
            [control resignFirstResponder];
            break;
        }
    }
    if(![self messageContentVerified])
        return;
    NSArray* usernames = [self usernameListFromText: view.recipientsField.text];
    if(usernames.count > [MPLimitConstants maxRecipientsPerMessage]) {
        UIAlertController* errorAlert =
        [UIAlertController alertControllerWithTitle:@"Error"
                                            message:[NSString stringWithFormat:@"You can only have up to %d recipients per message. You entered %lu.",
                                                     [MPLimitConstants maxRecipientsPerMessage],
                                                     (unsigned long)usernames.count]
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Go Back"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [errorAlert addAction: cancelAction];
        [self presentViewController: errorAlert animated:YES completion:nil];
        return;
    }
    [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    dispatch_async(dispatch_queue_create("VerifyUsernamesQueue", 0), ^{
        //NOTE: verifiedFriends contains PFUSERS, where
        //verifiedNotFriends contains NSSTRINGS (usernames)
        NSMutableArray* verifiedFriends = [[NSMutableArray alloc] initWithCapacity:usernames.count];
        NSMutableArray* verifiedNotFriends = [[NSMutableArray alloc] initWithCapacity:usernames.count];
        for(NSString* username in usernames) {
            PFQuery *query = [PFUser query];
            [query whereKey:@"username" equalTo:username];
            PFUser *user = (PFUser *)[query getFirstObject];
            MPFriendStatus status = [MPFriendsModel friendStatusFromUser:user toUser:[PFUser currentUser]];
            if(status == MPFriendStatusFriends || status == MPFriendStatusSameUser)
                [verifiedFriends addObject: user];
            else
                [verifiedNotFriends addObject:username];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(verifiedNotFriends.count == 0)
                [self sendMessageToUsers: verifiedFriends];
            else if(verifiedFriends.count > 0) {
                NSString* message = [NSString stringWithFormat:@"The following users you entered as recipients aren't on your friends list. You can choose to send the message to the remaining friends, or cancel.\n%@", verifiedNotFriends[0]];
                for(int i = 1; i < verifiedNotFriends.count; i++) {
                    message = [message stringByAppendingString:
                               [NSString stringWithFormat:@", %@",verifiedNotFriends[i]]];
                }
                UIAlertController* confirmation =
                [UIAlertController alertControllerWithTitle:@"Warning"
                                                    message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* sendAction = [UIAlertAction actionWithTitle:@"Send"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction* action) {
                                                                       [view.menu.subtitleLabel displayMessage:[MPMessageComposerView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
                                                                       [self sendMessageToUsers: verifiedFriends];
                                                                   }];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction* action) {
                                                                         [view.menu.subtitleLabel displayMessage:[MPMessageComposerView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
                                                                     }];
                [confirmation addAction: sendAction];
                [confirmation addAction: cancelAction];
                [self presentViewController: confirmation animated:YES completion:nil];
            }
            else {
                UIAlertController* errorAlert =
                [UIAlertController alertControllerWithTitle:@"Error"
                                                    message:@"None of the users you entered as recipients are on your friends list. Please double-check your entries."
                                             preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Go Back"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction* action){
                                                                         [view.menu.subtitleLabel displayMessage:[MPMessageComposerView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
                                                                     }];
                [errorAlert addAction: cancelAction];
                [self presentViewController: errorAlert animated:YES completion:nil];
            }
            
        });
    });
}

- (void) sendMessageToUsers: (NSArray*) recipients {
    MPMessageComposerView* view = ((MPMessageComposerView*)self.view);
    NSString* title = view.titleField.text;
    NSString* body = view.bodyView.text;
    __block BOOL allSuccesses = YES;
    for(PFUser* user in recipients) {
        PFObject* message = [PFObject objectWithClassName:@"Message"];
        message[@"sender"] = [PFUser currentUser];
        message[@"receiver"] = user;
        message[@"title"] = title;
        message[@"body"] = body;
        message[@"read"] = [NSNumber numberWithBool:NO];
        message[@"visibleToSender"] = [NSNumber numberWithBool:YES];
        message[@"visibleToReceiver"] = [NSNumber numberWithBool:YES];
        dispatch_async(dispatch_queue_create("CreateMessageQueue", 0), ^{
            BOOL success = [message save];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(!success) {
                    allSuccesses = NO;
                }
            });
        });
    }
    if(allSuccesses)
        [MPControllerManager dismissViewController: self];
    else
        [view.menu.subtitleLabel displayMessage:@"There was an error sending the message. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
    
}

- (BOOL) messageContentVerified {
    MPMessageComposerView* view = ((MPMessageComposerView*)self.view);
    NSString* title = view.titleField.text;
    NSString* body = view.bodyView.text;
    NSString* recipients = view.recipientsField.text;
    NSString* alertMessage;
    if(title.length == 0)
        alertMessage = @"You cannot leave a blank title.";
    else if(title.length > [MPLimitConstants maxMessageTitleCharacters])
        alertMessage = @"Your title is too long.";
    else if(body.length == 0)
        alertMessage = @"You cannot leave a blank message body.";
    else if(body.length > [MPLimitConstants maxMessageBodyCharacters])
        alertMessage = @"Your message body is too long.";
    else if(recipients.length == 0)
        alertMessage = @"Please enter at least one recipient.";
    if(alertMessage) {
        UIAlertController* errorAlert =
        [UIAlertController alertControllerWithTitle:@"Error"
                                            message:alertMessage
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Go Back"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [errorAlert addAction: cancelAction];
        [self presentViewController: errorAlert animated:YES completion:nil];
        return NO;
    }
    return YES;
    
}

- (NSArray*) usernameListFromText: (NSString*) text {
    NSArray* withoutWhitespace = [text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* noSpaceString = [withoutWhitespace componentsJoinedByString:@""];
    return [noSpaceString componentsSeparatedByString:@","];
}

- (void) keyboardWillShow: (NSNotification *)notification {
    MPMessageComposerView* view = ((MPMessageComposerView*)self.view);
    UIControl* responder;
    for(UIControl* control in @[view.recipientsField, view.titleField, view.bodyView]) {
        if([control isFirstResponder]) {
            responder = control;
            break;
        }
    }
    
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    self.keyboardHeight = height;
    
    if([responder isEqual: view.bodyView])
        responder = (UIControl*)view.sendButton;
    
    [self shiftConstraintToFocusControl: responder animationDuration: animationDuration];
}

- (void) shiftConstraintToFocusControl: (UIControl*) control animationDuration: (NSTimeInterval) animationDuration {
    CGFloat fieldBottom = control.frame.origin.y + control.frame.size.height;
    //Note: here we assume self.keyboardHeight has to be initialized, because a keyboard must have been
    //shown prior to this method call
    CGFloat shiftAmount = (self.view.frame.size.height - self.keyboardHeight - fieldBottom);
    
    if(shiftAmount >= 0) {
        [((MPMessageComposerView*)self.view) restoreDefaultConstraints];
        return;
    }
    
    [((MPMessageComposerView*)self.view) shiftVerticalConstraintsBy: shiftAmount];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void) keyboardWillHide: (NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [((MPMessageComposerView*)self.view) restoreDefaultConstraints];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSUInteger length = textView.text.length;
    int maxLength = [MPLimitConstants maxMessageBodyCharacters];
    MPMessageComposerView* view = (MPMessageComposerView*) self.view;
    [view.bodyLimitLabel setTextToInt:(maxLength-(int)length)];
}

- (void) titleFieldDidChange:(UITextField*) sender {
    NSUInteger length = sender.text.length;
    int maxLength = [MPLimitConstants maxMessageTitleCharacters];
    MPMessageComposerView* view = (MPMessageComposerView*) self.view;
    [view.titleLimitLabel setTextToInt:(maxLength-(int)length)];
}

- (BOOL) textFieldShouldReturn:(nonnull UITextField *)textField {
    MPMessageComposerView* view = (MPMessageComposerView*) self.view;
    if([textField isEqual: view.recipientsField]) {
        [view.titleField becomeFirstResponder];
        return YES;
    }
    else if([textField isEqual: view.titleField]){
        [view.bodyView becomeFirstResponder];
        return NO;
    }
    return YES;
}

@end
