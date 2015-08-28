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
#import "MPTeamsModel.h"
#import "MPFriendsModel.h"

#import "MPMakeEventView.h"
#import "MPEventNameView.h"
#import "MPEventTypeView.h"
#import "MPEventRuleView.h"
#import "MPEventParticipantsView.h"
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
            self.eligibleRules = @[];
            self.eligibleParticipants = @[];
            self.selectedParticipants = @[].mutableCopy;
            dispatch_async(dispatch_get_main_queue(), ^{
                MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
                [ruleView.rulesTable registerClass:[MPTableViewCell class] forCellReuseIdentifier:[MPMakeEventViewController ruleReuseIdentifier]];
                ruleView.rulesTable.delegate = self;
                ruleView.rulesTable.dataSource = self;
                [ruleView.rulesTable reloadData];
                
                MPEventParticipantsView* participantsView = (MPEventParticipantsView*)[view.form slideWithClass:[MPEventParticipantsView class]];
                [participantsView.participantsTable registerClass:[MPTableViewCell class] forCellReuseIdentifier:[MPMakeEventViewController participantReuseIdentifier]];
                participantsView.participantsTable.delegate = self;
                participantsView.participantsTable.dataSource = self;
                [participantsView.participantsTable reloadData];
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
            [self updateDataBeforeAdvance];
            if(!errorsFound) {
                if(view.form.slideViewIndex == view.form.slideViews.count - 1) {
                    [self performModelUpdateAndDismissOnSuccess:^{
                        return [MPEventsModel createEventWithName:self.eventName withOwner:[PFUser currentUser] withType:self.selectedEventType withRule:self.selectedRule withParticipants:self.selectedParticipants];
                    } withErrorMessage:@"There was an error saving your event. Please try again later."];
                }
                else {
                    [view.form advanceToNextSlide];
                }
            }
        });
    });
}

- (void) updateDataBeforeAdvance {
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    if([[view.form currentSlide] isKindOfClass:[MPEventNameView class]]) {
        MPEventNameView* nameView = (MPEventNameView*)[view.form currentSlide];
        self.eventName = nameView.nameField.text;
    }
    else if([[view.form currentSlide] isKindOfClass:[MPEventTypeView class]]) {
        dispatch_async(dispatch_queue_create("ReloadDataQueue", 0), ^{
            MPEventTypeView* typeView = (MPEventTypeView*)[view.form slideWithClass:[MPEventTypeView class]];
            self.selectedEventType = [typeView selectedEventType];
            self.eligibleRules = [self generateEligibleRulesForEventType:self.selectedEventType];
            dispatch_async(dispatch_get_main_queue(), ^{
                MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
                [ruleView.rulesTable reloadData];
                self.selectedRule = nil;
            });
        });
    }
    else if([[view.form currentSlide] isKindOfClass:[MPEventRuleView class]]) {
        dispatch_async(dispatch_queue_create("ReloadDataQueue", 0), ^{
            self.eligibleParticipants = [self generateEligibleParticipantsForRule: self.selectedRule];
            dispatch_async(dispatch_get_main_queue(), ^{
                MPEventParticipantsView* participantsView = (MPEventParticipantsView*)[view.form slideWithClass:[MPEventParticipantsView class]];
                [participantsView.participantsTable reloadData];
                self.selectedParticipants = @[].mutableCopy;
            });
        });
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

- (void) makeRuleButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMakeRuleViewController alloc] init] fromController:self];
}

- (BOOL) errorFoundInSubview: (MPView*) subview {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    if([subview isKindOfClass:[MPEventNameView class]]) {
        MPTextField* nameField = ((MPEventNameView*)subview).nameField;
        [alerter checkErrorCondition:(nameField.text.length < [MPLimitConstants minEventNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minRuleNameCharacters]]];
        [alerter checkErrorCondition:(nameField.text.length > [MPLimitConstants maxEventNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxRuleNameCharacters]]];
    }
    else if([subview isKindOfClass:[MPEventRuleView class]]) {
        [alerter checkErrorCondition:(self.selectedRule == nil) withMessage:@"Please select a rule."];
    }
    else if([subview isKindOfClass:[MPEventParticipantsView class]]) {
        [alerter checkErrorCondition:![self validNumberOfParticipants] withMessage:[self makeNumberOfParticipantsMessage]];
    }
    return [alerter hasFoundError];
}

- (BOOL) validNumberOfParticipants {
    int participantsPerMatch = [self.selectedRule[@"participantsPerMatch"] intValue];
    if(self.selectedEventType == MPEventTypeMatch) {
        return (self.selectedParticipants.count == participantsPerMatch);
    }
    return (self.selectedParticipants.count >= participantsPerMatch);
}

- (NSString*) makeNumberOfParticipantsMessage {
    int participantsPerMatch = [self.selectedRule[@"participantsPerMatch"] intValue];
    if(self.selectedEventType == MPEventTypeMatch) {
        return [NSString stringWithFormat:@"You need to select exactly %d participants for your match (you currently have %lu selected).", participantsPerMatch, (unsigned long)self.selectedParticipants.count];
    }
    return [NSString stringWithFormat:@"You need at least %d participants for your event (you currently have %lu selected).", participantsPerMatch, (unsigned long)self.selectedParticipants.count];
}

#pragma mark UITableView

- (NSArray*) generateEligibleRulesForEventType: (MPEventType) eventType {
    if(eventType == MPEventTypeLeague || eventType == MPEventTypeTournament)
        return [MPRulesModel rulesForUserWith2ParticipantsPerMatch:[PFUser currentUser]];
    return [MPRulesModel rulesForUser:[PFUser currentUser]];
}

- (NSArray*) generateEligibleParticipantsForRule: (PFObject*) rule {
    BOOL usesTeams = [rule[@"usesTeamParticipants"] boolValue];
    if(usesTeams)
        return [MPTeamsModel teamsVisibleToUser: [PFUser currentUser]];
    NSMutableArray* players = [MPFriendsModel friendsForUser:[PFUser currentUser]].mutableCopy;
    [players addObject: [PFUser currentUser]];
    return players;
}

- (UITableViewCell*) tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MPMakeEventView* view = (MPMakeEventView*)self.view;
    MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
    if([tableView isEqual: ruleView.rulesTable]) {
        MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPMakeEventViewController ruleReuseIdentifier] forIndexPath:indexPath];
        
        if(!cell)
            cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeEventViewController ruleReuseIdentifier]];
        
        cell.indexPath = indexPath;
        [cell setNumberOfButtons: 0];
        [MPTableSectionUtility updateCell:cell withRuleObject:self.eligibleRules[indexPath.row]];
        
        return cell;
    }
    else {
        MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPMakeEventViewController participantReuseIdentifier] forIndexPath:indexPath];
        
        if(!cell)
            cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeEventViewController participantReuseIdentifier]];
        
        cell.indexPath = indexPath;
        [cell setNumberOfButtons: 0];
        
        BOOL usesTeams = [self.selectedRule[@"usesTeamParticipants"] boolValue];
        if(usesTeams)
            [MPTableSectionUtility updateCell:cell withTeamObject:self.eligibleParticipants[indexPath.row]];
        else
            [MPTableSectionUtility updateCell:cell withUserObject:self.eligibleParticipants[indexPath.row]];
        
        return cell;
    }
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MPMakeEventView* view = (MPMakeEventView*)self.view;
    MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
    if([tableView isEqual: ruleView.rulesTable]) {
        return self.eligibleRules.count;
    }
    return self.eligibleParticipants.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMakeEventView* view = (MPMakeEventView*)self.view;
    MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
    if([tableView isEqual: ruleView.rulesTable]) {
        PFObject* rule = self.eligibleRules[indexPath.row];
        self.selectedRule = rule;
    }
    else {
        id participant = self.eligibleParticipants[indexPath.row];
        [self.selectedParticipants addObject:participant];
    }
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MPMakeEventView* view = (MPMakeEventView*)self.view;
    MPEventParticipantsView* participantView = (MPEventParticipantsView*)[view.form slideWithClass:[MPEventParticipantsView class]];
    if([tableView isEqual:participantView.participantsTable]) {
        id participant = self.eligibleParticipants[indexPath.row];
        [self.selectedParticipants removeObject:participant];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MPMakeEventView* view = (MPMakeEventView*)self.view;
    MPEventRuleView* ruleView = (MPEventRuleView*)[view.form slideWithClass:[MPEventRuleView class]];
    if([tableView isEqual: ruleView.rulesTable]) {
        return [[MPTableHeader alloc] initWithText:@"RULES"];
    }
    return [[MPTableHeader alloc] initWithText:@"PARTICIPANTS"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

+ (NSString*) ruleReuseIdentifier { return @"RuleCell"; }
+ (NSString*) participantReuseIdentifier { return @"ParticipantCell"; }

@end
