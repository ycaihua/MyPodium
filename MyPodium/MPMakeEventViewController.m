//
//  MPMakeEventViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPErrorAlerter.h"
#import "MPLimitConstants.h"
#import "MPControllerManager.h"

#import "MPEventsModel.h"

#import "MPMakeEventView.h"
#import "MPEventNameView.h"
#import "MPEventTypeView.h"
#import "MPEventRuleView.h"
#import "MPFormView.h"
#import "MPTextField.h"
#import "MPBottomEdgeButton.h"

#import "MPMakeEventViewController.h"

#import <Parse/Parse.h>

@interface MPMakeEventViewController ()

@end

@implementation MPMakeEventViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeEventView* view = [[MPMakeEventView alloc] init];
        self.view = view;
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    
    [view.form.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.form.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    MPEventNameView* nameView = (MPEventNameView*)[view.form slideWithClass:[MPEventNameView class]];
    nameView.nameField.delegate = self;
    
    MPEventTypeView* typeView = (MPEventTypeView*)[view.form slideWithClass:[MPEventTypeView class]];
    for(UIButton* button in typeView.allButtons) {
        [button addTarget:self action:@selector(typeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (BOOL) textFieldShouldReturn:(nonnull UITextField *)textField {
    [textField resignFirstResponder];
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    MPEventNameView* nameView = (MPEventNameView*)[view.form slideWithClass:[MPEventNameView class]];
    MPTextField* nameField = nameView.nameField;
    if([textField isEqual: nameField]) {
        [self nextButtonPressed: self];
        return YES;
    }
    return YES;
}

- (void) nextButtonPressed: (id) sender {
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    MPView* focusedSubview = [view.form currentSlide];
    BOOL errorsFound = [self errorFoundInSubview: focusedSubview];
    if(!errorsFound) {
        if(view.form.slideViewIndex == view.form.slideViews.count - 1) {
            
        }
        else {
            [view.form advanceToNextSlide];
        }
    }
}

- (void) previousButtonPressed: (id) sender {
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    if(view.form.slideViewIndex == 0) {
        [MPControllerManager dismissViewController:self];
    }
    else {
        [view.form returnToLastSlide];
    }
}

- (void) typeButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    MPEventTypeView* typeView = (MPEventTypeView*)[view.form slideWithClass:[MPEventTypeView class]];
    [typeView changeIndexSelected: (int)[typeView.allButtons indexOfObject:buttonSender]];
    MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
    [ruleView updateForEventType:[typeView selectedEventType]];
}

- (BOOL) errorFoundInSubview: (MPView*) subview {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    if([subview isKindOfClass:[MPEventNameView class]]) {
        MPTextField* nameField = ((MPEventNameView*)subview).nameField;
        [alerter checkErrorCondition:(nameField.text.length < [MPLimitConstants minEventNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minRuleNameCharacters]]];
        [alerter checkErrorCondition:(nameField.text.length > [MPLimitConstants maxEventNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxRuleNameCharacters]]];
        //need to move to background somehow
        [alerter checkErrorCondition:[MPEventsModel eventNameInUse:nameField.text forUser:[PFUser currentUser]] withMessage:@"You have already used this name for an event before. Please try another."];
        return [alerter hasFoundError];
    }
    else {
        return NO;
    }
}


@end
