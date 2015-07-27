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

#import "MPMakeRuleViewController.h"
#import "MPMakeRuleView.h"
#import "MPBottomEdgeButton.h"
#import "MPTextField.h"
#import "MPLabel.h"

@interface MPMakeRuleViewController ()

@end

@implementation MPMakeRuleViewController

- (id) init {
    NSLog(@"A");
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
    
    MPTextField* nameField = (MPTextField*)[view.ruleSubviews[0] viewWithTag:3];
    nameField.delegate = self;
    
    UIButton* decrementButton = (UIButton*)[view.ruleSubviews[1] viewWithTag:5];
    [decrementButton addTarget:self action:@selector(decrementCounterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* incrementButton = (UIButton*)[view.ruleSubviews[1] viewWithTag:6];
    [incrementButton addTarget:self action:@selector(incrementCounterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [view.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) decrementCounterButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPLabel* counter = (MPLabel*)[view.ruleSubviews[1] viewWithTag:4];
    [counter decrementTextAndRevertAfter:NO withBound:2];
}

- (void) incrementCounterButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPLabel* counter = (MPLabel*)[view.ruleSubviews[1] viewWithTag:4];
    [counter incrementTextAndRevertAfter:NO withBound:[MPLimitConstants maxPlayersPerTeam]];
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
    return @[^(UIView* subview, MPErrorAlerter* alerter) {
        MPTextField* usernameField = (MPTextField*)[subview viewWithTag:3];
        [alerter checkErrorCondition:(usernameField.text.length < [MPLimitConstants minGameModeCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minGameModeCharacters]]];
        [alerter checkErrorCondition:(usernameField.text.length > [MPLimitConstants maxGameModeCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxGameModeCharacters]]];
        
        return [alerter hasFoundError];
        
    },
              ^(UIView* subview, MPErrorAlerter* alerter) {
                  return NO;
              }
              ];
}

- (void) keyboardWillShow: (NSNotification*) notification {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    if(view.subviewIndex == 0) {
        [view adjustNameSubviewForKeyboardShowing: YES];
    }
    else if(view.subviewIndex == 2) {
        MPView* activeSubview = view.ruleSubviews[view.subviewIndex];
        MPTextField* playerStatsField = (MPTextField*)[activeSubview viewWithTag:3];
        MPTextField* teamStatsField = (MPTextField*)[activeSubview viewWithTag:5];
        if([playerStatsField isFirstResponder]) {
            [view adjustStatSubviewForKeyboardShowing:YES withField:playerStatsField];
        }
        else {
            [view adjustStatSubviewForKeyboardShowing:YES withField:teamStatsField];
        }
    }
}

- (void) keyboardWillHide: (NSNotification*) notification {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    if(view.subviewIndex == 0) {
        [view adjustNameSubviewForKeyboardShowing: NO];
    }
    else if(view.subviewIndex == 2) {
        MPView* activeSubview = view.ruleSubviews[view.subviewIndex];
        MPTextField* playerStatsField = (MPTextField*)[activeSubview viewWithTag:3];
        MPTextField* teamStatsField = (MPTextField*)[activeSubview viewWithTag:5];
        if([playerStatsField isFirstResponder]) {
            [view adjustStatSubviewForKeyboardShowing:NO withField:playerStatsField];
        }
        else {
            [view adjustStatSubviewForKeyboardShowing:NO withField:teamStatsField];
        }
    }
}

- (BOOL) textFieldShouldReturn:(nonnull UITextField *)textField {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPTextField* nameField = (MPTextField*)[view.ruleSubviews[0] viewWithTag:3];
    if([textField isEqual: nameField] && textField.text.length > 0) {
        [self nextButtonPressed: self];
    }
    [textField resignFirstResponder];
    return YES;
}

@end
