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
#import "MPRuleWinConditionStatView.h"
#import "MPRuleWinConditionValueView.h"
#import "MPBottomEdgeButton.h"
#import "MPTextField.h"
#import "MPLabel.h"
#import "MPRuleStatCell.h"
#import "MPTableHeader.h"

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
    
    MPRuleWinConditionStatView* winView = view.ruleSubviews[4];
    [winView.statTable registerClass:[MPRuleStatCell class]
  forCellReuseIdentifier:[MPMakeRuleViewController statsReuseIdentifier]];
    winView.statTable.delegate = self;
    winView.statTable.dataSource = self;
    
    [view.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) nextButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    UIView* focusedSubview = view.ruleSubviews[view.subviewIndex];
    
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    BOOL errorsFound = NO;
    if([focusedSubview isKindOfClass:[MPRuleNameView class]]) {
        MPTextField* nameField = ((MPRuleNameView*)focusedSubview).nameField;
        [alerter checkErrorCondition:(nameField.text.length < [MPLimitConstants minRuleNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minRuleNameCharacters]]];
        [alerter checkErrorCondition:(nameField.text.length > [MPLimitConstants maxRuleNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxRuleNameCharacters]]];
        errorsFound = [alerter hasFoundError];
    }
    
    dispatch_async(dispatch_queue_create("CheckErrorsQueue", 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!errorsFound) {
                if([focusedSubview isKindOfClass: [MPRuleStatsView class]]) {
                    self.statNameData = [self statsFromStatsSubview];
                    MPRuleWinConditionStatView* winView = view.ruleSubviews[view.subviewIndex + 1];
                    [winView.statTable reloadData];
                }
                else if([focusedSubview isKindOfClass: [MPRuleWinConditionStatView class]]) {
                    MPRuleWinConditionValueView* valueView = view.ruleSubviews[view.subviewIndex + 1];
                    [valueView updateWithStatName: [self winConditionStatName]];
                }
                [view advanceToNextSubview];
                [view.previousButton setTitle:@"PREVIOUS" forState:UIControlStateNormal];
                [view.previousButton enable];
                if(view.subviewIndex == view.ruleSubviews.count - 1 || view.subviewIndex == 4) {
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

- (NSString*) winConditionStatName {
    NSDictionary* sectionData = self.statNameData[self.selectedPath.section];
    NSArray* stats = [sectionData objectForKey:[[sectionData allKeys] objectAtIndex:0]];
    return stats[self.selectedPath.row];
}

/*
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
              },
              ^(UIView* subview, MPErrorAlerter* alerter) {
                  return NO;
              }];
}
*/

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

- (void) textFieldDidBeginEditing:(nonnull UITextField *)textField {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPRuleStatsView* statsView = view.ruleSubviews[3];
    if([textField isEqual: statsView.teamStatsField]) {
        [self keyboardWillShow: nil];
    }
}

- (NSMutableArray*) statsFromStatsSubview {
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity:2];
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPRuleStatsView* statsView = view.ruleSubviews[3];
    NSString* playerStatsString = statsView.playerStatsField.text;
    NSMutableArray* playerStats = [playerStatsString componentsSeparatedByString:@","].mutableCopy;
    for(int i = 0; i < playerStats.count; i++) {
        playerStats[i] = [playerStats[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    NSMutableArray* uniquePlayerStats = [[NSSet setWithArray:playerStats] allObjects].mutableCopy;
    [uniquePlayerStats removeObject:@""];
    if(uniquePlayerStats.count > 0)
        [results addObject:@{@"PLAYER STATS": uniquePlayerStats}];
    NSString* teamStatsString = statsView.teamStatsField.text;
    NSMutableArray* teamStats = [teamStatsString componentsSeparatedByString:@","].mutableCopy;
    for(int i = 0; i < teamStats.count; i++) {
        teamStats[i] = [teamStats[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    NSMutableArray* uniqueTeamStats = [[NSSet setWithArray:teamStats] allObjects].mutableCopy;
    [uniqueTeamStats removeObject:@""];
    if(uniqueTeamStats.count > 0)
        [results addObject:@{@"TEAM STATS": uniqueTeamStats}];
    
    return results;
}

- (NSInteger) numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return self.statNameData.count;
}

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary* sectionData = self.statNameData[section];
    NSArray* stats = [sectionData objectForKey:[[sectionData allKeys] objectAtIndex:0]];
    return stats.count;
}

- (UITableViewCell*) tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MPRuleStatCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPMakeRuleViewController statsReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPRuleStatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeRuleViewController statsReuseIdentifier]];
    }
    cell.indexPath = indexPath;
    
    NSDictionary* sectionData = self.statNameData[indexPath.section];
    NSArray* stats = [sectionData objectForKey:[[sectionData allKeys] objectAtIndex:0]];
    cell.nameLabel.text = stats[indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPRuleStatCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:[self.statNameData[section] allKeys][0]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    [view.nextButton enable];
    self.selectedPath = indexPath;
}

+ (NSString*) statsReuseIdentifier { return @"StatsIdentifier"; }

@end
