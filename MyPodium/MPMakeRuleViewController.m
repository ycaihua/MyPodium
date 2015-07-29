//
//  MPMakeRuleViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"
#import "MPLimitConstants.h"
#import "MPErrorAlerter.h"

#import "MPMakeRuleView.h"
#import "MPRuleNameView.h"
#import "MPRuleParticipantView.h"
#import "MPRuleStatsView.h"
#import "MPBottomEdgeButton.h"
#import "MPTextField.h"
#import "MPLabel.h"

#import "MPMakeRuleViewController.h"

@interface MPMakeRuleViewController ()

@end

@implementation MPMakeRuleViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeRuleView* view = [[MPMakeRuleView alloc] init];
        self.view = view;
        [self makeControlActions];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void) makeControlActions {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    
    MPRuleNameView* nameView = view.ruleSubviews[0];
    nameView.nameField.delegate = self;
    
    MPRuleStatsView* statsView = view.ruleSubviews[3];
    statsView.playerStatsField.delegate = self;
    statsView.teamStatsField.delegate = self;
    
    [view.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) nextButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    UIView* focusedSubview = view.ruleSubviews[view.subviewIndex];
    
    BOOL (^block)(UIView* subview, MPErrorAlerter* alerter) =
    [MPMakeRuleViewController errorCheckingBlocks][view.subviewIndex];
    
    dispatch_async(dispatch_queue_create("CheckErrorsQueue", 0), ^{
        BOOL errorsFound = block(focusedSubview, alerter);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!errorsFound) {
                [view advanceToNextSubview];
                [view.previousButton setTitle:@"PREVIOUS" forState:UIControlStateNormal];
                [view.previousButton enable];
                if(view.subviewIndex == view.ruleSubviews.count - 1) {
                    [view.nextButton disable];
                }
                else {
                    [view.nextButton enable];
                }
            }
        });
    });
    
}

- (void) previousButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    if(view.subviewIndex == 0) {
        [MPControllerManager dismissViewController:self];
    }
    else {
        [view returnToLastSubview];
        [view.nextButton enable];
        if(view.subviewIndex == 0) {
            [view.previousButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        }
        else {
            [view.previousButton setTitle:@"PREVIOUS" forState:UIControlStateNormal];
        }
    }
}

+ (NSArray*) errorCheckingBlocks {
    return @[^(MPView* subview, MPErrorAlerter* alerter) {
        MPTextField* usernameField = ((MPRuleNameView*)subview).nameField;
        [alerter checkErrorCondition:(usernameField.text.length < [MPLimitConstants minRuleNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minRuleNameCharacters]]];
        [alerter checkErrorCondition:(usernameField.text.length > [MPLimitConstants maxRuleNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxRuleNameCharacters]]];
        
        return [alerter hasFoundError];
        
    },
              ^(UIView* subview, MPErrorAlerter* alerter) {
                  return NO;
              },
              ^(UIView* subview, MPErrorAlerter* alerter) {
                  return NO;
              },
              ^(UIView* subview, MPErrorAlerter* alerter) {
                  return NO;
              }];
}

- (void) keyboardWillShow: (NSNotification*) notification {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPView* activeView = view.ruleSubviews[view.subviewIndex];
   if([activeView isKindOfClass:[MPRuleStatsView class]]) {
       if([((MPRuleStatsView*)activeView).teamStatsField isFirstResponder]) {
            [((MPRuleStatsView*)activeView) adjustForKeyboardShowing:YES];
        }
    }
}

- (void) keyboardWillHide: (NSNotification*) notification {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPView* activeView = view.ruleSubviews[view.subviewIndex];
    if([activeView isKindOfClass:[MPRuleStatsView class]]) {
        if([((MPRuleStatsView*)activeView).teamStatsField isFirstResponder]) {
            [((MPRuleStatsView*)activeView) adjustForKeyboardShowing:NO];
        }
    }}

- (BOOL) textFieldShouldReturn:(nonnull UITextField *)textField {
    [textField resignFirstResponder];
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPRuleNameView* nameView = view.ruleSubviews[0];
    MPTextField* nameField = nameView.nameField;
    if([textField isEqual: nameField]) {
        [self nextButtonPressed: self];
        return YES;
    }
    MPRuleStatsView* statsView = view.ruleSubviews[3];
    if([textField isEqual: statsView.playerStatsField] && !statsView.teamStatsField.hidden) {
        [statsView.teamStatsField becomeFirstResponder];
        return YES;
    }
    else {
        [self nextButtonPressed: self];
        return YES;
    }
    return YES;
}

@end
