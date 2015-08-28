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
#import "MPRulesModel.h"

#import "MPMakeEventView.h"
#import "MPEventNameView.h"
#import "MPEventTypeView.h"
#import "MPEventRuleView.h"
#import "MPFormView.h"
#import "MPTextField.h"
#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPTableSectionUtility.h"
#import "MPTableViewCell.h"

#import "MPMakeEventViewController.h"
#import "MPMakeRuleViewController.h"

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
        dispatch_async(dispatch_queue_create("TableQueue", 0), ^{
            self.eligibleRules = [self generateEligibleRulesForEventType:MPEventTypeMatch];
            dispatch_async(dispatch_get_main_queue(), ^{
                MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
                [ruleView.rulesTable registerClass:[MPTableViewCell class] forCellReuseIdentifier:[MPMakeEventViewController ruleReuseIdentifier]];
                ruleView.rulesTable.delegate = self;
                ruleView.rulesTable.dataSource = self;
                [ruleView.rulesTable reloadData];
            });
        });
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
    
    MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
    [ruleView.makeRuleButton addTarget:self action:@selector(makeRuleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    dispatch_async(dispatch_queue_create("CheckErrorsQueue", 0), ^{
        BOOL errorsFound = [self errorFoundInSubview: focusedSubview];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!errorsFound) {
                if(view.form.slideViewIndex == view.form.slideViews.count - 1) {
                    
                }
                else {
                    [view.form advanceToNextSlide];
                }
            }
        });
    });
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

- (void) makeRuleButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMakeRuleViewController alloc] init] fromController:self];
}

- (BOOL) errorFoundInSubview: (MPView*) subview {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    if([subview isKindOfClass:[MPEventNameView class]]) {
        MPTextField* nameField = ((MPEventNameView*)subview).nameField;
        [alerter checkErrorCondition:(nameField.text.length < [MPLimitConstants minEventNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minRuleNameCharacters]]];
        [alerter checkErrorCondition:(nameField.text.length > [MPLimitConstants maxEventNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxRuleNameCharacters]]];
        [alerter checkErrorCondition:[MPEventsModel eventNameInUse:nameField.text forUser:[PFUser currentUser]] withMessage:@"You have already used this name for an event before. Please try another."];
    }
    else if([subview isKindOfClass:[MPEventRuleView class]]) {
        [alerter checkErrorCondition:(self.selectedRule == nil) withMessage:@"Please select a rule."];
    }
    return [alerter hasFoundError];
}

#pragma mark UITableView

- (NSArray*) generateEligibleRulesForEventType: (MPEventType) eventType {
    if(eventType == MPEventTypeLeague || eventType == MPEventTypeTournament)
        return [MPRulesModel rulesForUserWith2ParticipantsPerMatch:[PFUser currentUser]];
    else return [MPRulesModel rulesForUser:[PFUser currentUser]];
}

- (UITableViewCell*) tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                             [MPMakeEventViewController ruleReuseIdentifier] forIndexPath:indexPath];
    
    if(!cell)
        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeEventViewController ruleReuseIdentifier]];
    
    cell.indexPath = indexPath;
    [cell setNumberOfButtons: 0];
    [MPTableSectionUtility updateCell:cell withRuleObject:self.eligibleRules[indexPath.row]];
    
    return cell;
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eligibleRules.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject* rule = self.eligibleRules[indexPath.row];
    self.selectedRule = rule;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:@"RULES"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

+ (NSString*) ruleReuseIdentifier { return @"RuleCell"; }

@end
