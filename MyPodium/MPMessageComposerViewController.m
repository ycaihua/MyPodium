//
//  MPMessageComposerViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLimitConstants.h"

#import "MPLabel.h"
#import "MPTextField.h"
#import "MPMessageComposerView.h"

#import "MPMessageComposerViewController.h"

@interface MPMessageComposerViewController ()

@end

@implementation MPMessageComposerViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMessageComposerView* view = [[MPMessageComposerView alloc] init];
        view.bodyView.delegate = self;
        [view.titleField addTarget:self
                      action:@selector(titleFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        self.view = view;
    }
    return self;
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
    
    [self shiftConstraintToFocusControl: responder animationDuration: animationDuration];
}

- (void) shiftConstraintToFocusControl: (UIControl*) control animationDuration: (NSTimeInterval) animationDuration {
    CGFloat fieldBottom = control.frame.origin.y + control.frame.size.height;
    //Note: here we assume self.keyboardHeight has to be initialized, because a keyboard must have been
    //shown prior to this method call
    CGFloat shiftAmount = (self.view.frame.size.height - self.keyboardHeight - fieldBottom - 15);
    
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

@end
