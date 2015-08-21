//
//  MPMakeRuleViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "MPControllerManager.h"
#import "MPLimitConstants.h"
#import "MPErrorAlerter.h"

#import "MPRulesModel.h"

#import "MPRuleButton.h"
#import "MPMakeRuleView.h"
#import "MPBottomEdgeButton.h"
#import "MPTextField.h"
#import "MPLabel.h"
#import "MPMenu.h"
#import "MPTableViewCell.h"
#import "MPTableHeader.h"

#import "MPFormView.h"
#import "MPRuleNameView.h"
#import "MPRuleParticipantView.h"
#import "MPRuleParticipantsPerMatchView.h"
#import "MPRuleStatsView.h"
#import "MPRuleWinConditionStatView.h"
#import "MPRuleScoreLimitView.h"

#import "MPMakeRuleViewController.h"

#import <Parse/Parse.h>

@interface MPMakeRuleViewController ()

@end

@implementation MPMakeRuleViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeRuleView* view = [[MPMakeRuleView alloc] init];
        self.view = view;
        [self makeControlActions];
        self.scoreLimitEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void) makeControlActions {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    
    MPRuleNameView* nameView = (MPRuleNameView*)[view.form slideWithClass:[MPRuleNameView class]];
    nameView.nameField.delegate = self;
    
    MPRuleStatsView* statsView = (MPRuleStatsView*)[view.form slideWithClass:[MPRuleStatsView class]];;
    statsView.playerStatsField.delegate = self;
    statsView.teamStatsField.delegate = self;
    
    MPRuleWinConditionStatView* winView = (MPRuleWinConditionStatView*)[view.form slideWithClass:[MPRuleWinConditionStatView class]];
    [winView.statTable registerClass:[MPTableViewCell class]
  forCellReuseIdentifier:[MPMakeRuleViewController statsReuseIdentifier]];
    winView.statTable.delegate = self;
    winView.statTable.dataSource = self;
    
    MPRuleScoreLimitView* scoreView = (MPRuleScoreLimitView*)[view.form slideWithClass:[MPRuleScoreLimitView class]];
    [scoreView.scoreLimitButton addTarget:self action:@selector(scoreLimitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [view.form.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.form.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) nextButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPView* focusedSubview = [view.form currentSlide];
    dispatch_async(dispatch_queue_create("CheckErrorsQueue", 0), ^{
        BOOL errorsFound = [self errorFoundInSubview: focusedSubview];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!errorsFound) {
                if([focusedSubview isKindOfClass: [MPRuleStatsView class]]) {
                    self.statNameData = [self statsFromStatsSubview];
                    MPRuleWinConditionStatView* winView = (MPRuleWinConditionStatView*)[view.form slideWithClass:[MPRuleWinConditionStatView class]];
                    [winView.statTable reloadData];
                }
                else if([focusedSubview isKindOfClass: [MPRuleWinConditionStatView class]]) {
                    MPRuleScoreLimitView* valueView = (MPRuleScoreLimitView*)[view.form slideWithClass:[MPRuleScoreLimitView class]];
                    [valueView updateWithStatName: [self winConditionStatName]];
                }
                else if([focusedSubview isKindOfClass: [MPRuleParticipantsPerMatchView class]]) {
                    MPRuleStatsView* statsView = (MPRuleStatsView*)[view.form slideWithClass:[MPRuleStatsView class]];
                    [statsView.playerStatsField becomeFirstResponder];
                }
                if(view.form.slideViewIndex == view.form.slideViews.count - 1) {
                    [self createAndSaveGameMode];
                    return;
                }
                [view.form advanceToNextSlide];
                if([[view.form currentSlide] isKindOfClass:[MPRuleWinConditionStatView class]]) {
                    [view.form.nextButton disable];
                }
                else {
                    [view.form.nextButton enable];
                }
            }
        });
    });
}

- (void) previousButtonPressed: (id) sender {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    [view.form.nextButton enable];
    if(view.form.slideViewIndex == 0) {
        [MPControllerManager dismissViewController:self];
    }
    else {
        [view.form returnToLastSlide];
    }
}

- (BOOL) errorFoundInSubview: (MPView*) subview {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    if([subview isKindOfClass:[MPRuleNameView class]]) {
        MPTextField* nameField = ((MPRuleNameView*)subview).nameField;
        [alerter checkErrorCondition:(nameField.text.length < [MPLimitConstants minRuleNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names must be at least %d characters long.", [MPLimitConstants minRuleNameCharacters]]];
        [alerter checkErrorCondition:(nameField.text.length > [MPLimitConstants maxRuleNameCharacters]) withMessage:[NSString stringWithFormat:@"Rule names can be at most %d characters long.", [MPLimitConstants maxRuleNameCharacters]]];
        [alerter checkErrorCondition:[MPRulesModel ruleNameInUse:nameField.text forUser:[PFUser currentUser]] withMessage:@"You have already used this name for a set of rules before. Please try another."];
    }
    else if([subview isKindOfClass: [MPRuleStatsView class]]) {
        self.statNameData = [self statsFromStatsSubview];
        [alerter checkErrorCondition:(self.statNameData.count == 0) withMessage:@"You need at least one statistic to track (so you can tell who wins in your games)!"];
    }
    return [alerter hasFoundError];
}

- (void) scoreLimitButtonPressed: (id) sender {
    MPRuleButton* buttonSender = (MPRuleButton*) sender;
    [buttonSender toggleSelected];
    self.scoreLimitEnabled = [buttonSender toggledOn];
}

- (NSString*) winConditionStatName {
    NSDictionary* sectionData = self.statNameData[self.selectedPath.section];
    NSArray* stats = [sectionData objectForKey:[[sectionData allKeys] objectAtIndex:0]];
    return stats[self.selectedPath.row];
}

- (void) createAndSaveGameMode {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    NSString* name = ((MPRuleNameView*)[view.form slideWithClass:[MPRuleNameView class]]).nameField.text;
    NSString* name_searchable = name.lowercaseString;
    NSNumber* usesTeamParticipants = [NSNumber numberWithBool: !((MPRuleParticipantView*)[view.form slideWithClass:[MPRuleParticipantView class]]).participantsButton.toggledOn];
    NSNumber* playersPerTeam = @0;
    if(usesTeamParticipants.boolValue) {
        playersPerTeam = [NSNumber numberWithInt: ((MPRuleParticipantView*)[view.form slideWithClass:[MPRuleParticipantView class]]).playersPerTeamCounter.text.intValue];
    }
    NSNumber* participantsPerMatch = [NSNumber numberWithInt:((MPRuleParticipantsPerMatchView*)[view.form slideWithClass:[MPRuleParticipantsPerMatchView class]]).participantsPerMatchCounter.text.intValue];
    
    NSArray* playerStats = self.statNameData[0][@"PLAYER STATS"];
    NSArray* teamStats = @[];
    if(usesTeamParticipants.boolValue) {
        teamStats = self.statNameData[1][@"TEAM STATS"];
    }
    NSArray* winConditionStatPath = @[[NSNumber numberWithInteger:self.selectedPath.section], [NSNumber numberWithInteger:self.selectedPath.row]];
    
    NSNumber* scoreLimit = @0;
    if(self.scoreLimitEnabled) {
        scoreLimit = [NSNumber numberWithInt: ((MPRuleScoreLimitView*)[view.form slideWithClass:[MPRuleScoreLimitView class]]).winConditionCounter.text.intValue];
    }
    
    dispatch_async(dispatch_queue_create("CreateRuleQueue", 0), ^{
        NSDictionary* settings = @{@"name": name, @"name_searchable": name_searchable, @"usesTeamParticipants": usesTeamParticipants, @"playersPerTeam": playersPerTeam, @"participantsPerMatch": participantsPerMatch, @"playerStats": playerStats, @"teamStats": teamStats, @"winConditionStatPath": winConditionStatPath, @"scoreLimitEnabled": [NSNumber numberWithBool:self.scoreLimitEnabled], @"scoreLimit": scoreLimit};
        BOOL success = [MPRulesModel makeRuleWithCreator:[PFUser currentUser] withSettingsDictionary:settings];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success)
               [MPControllerManager dismissViewController: self];
            else {
               [view.menu.subtitleLabel displayMessage:@"There was an error saving your rules. Please try again later." revertAfter:YES withColor:[UIColor MPRedColor]];
            }
        });
    });
}

- (void) keyboardWillShow: (NSNotification*) notification {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPView* activeView = [view.form currentSlide];
    if([activeView isKindOfClass:[MPRuleStatsView class]]) {
       if([((MPRuleStatsView*)activeView).teamStatsField isFirstResponder]) {
            [((MPRuleStatsView*)activeView) adjustForKeyboardShowing:YES];
        }
    }
}

- (void) keyboardWillHide: (NSNotification*) notification {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPView* activeView = [view.form currentSlide];
    if([activeView isKindOfClass:[MPRuleStatsView class]]) {
        if([((MPRuleStatsView*)activeView).teamStatsField isFirstResponder]) {
            [((MPRuleStatsView*)activeView) adjustForKeyboardShowing:NO];
        }
    }
}

- (BOOL) textFieldShouldReturn:(nonnull UITextField *)textField {
    [textField resignFirstResponder];
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPRuleNameView* nameView = (MPRuleNameView*)[view.form slideWithClass:[MPRuleNameView class]];
    MPTextField* nameField = nameView.nameField;
    if([textField isEqual: nameField]) {
        [self nextButtonPressed: self];
        return YES;
    }
    MPRuleStatsView* statsView = (MPRuleStatsView*)[view.form slideWithClass:[MPRuleStatsView class]];
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
    MPRuleStatsView* statsView = (MPRuleStatsView*)[view.form slideWithClass:[MPRuleStatsView class]];
    if([textField isEqual: statsView.teamStatsField]) {
        [self keyboardWillShow: nil];
    }
}

- (NSMutableArray*) statsFromStatsSubview {
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity:2];
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    MPRuleStatsView* statsView = (MPRuleStatsView*)[view.form slideWithClass:[MPRuleStatsView class]];
    
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
    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPMakeRuleViewController statsReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeRuleViewController statsReuseIdentifier]];
    }
    cell.indexPath = indexPath;
    
    [cell setNumberOfButtons:0];
    
    NSDictionary* sectionData = self.statNameData[indexPath.section];
    NSArray* stats = [sectionData objectForKey:[[sectionData allKeys] objectAtIndex:0]];
    cell.titleLabel.text = stats[indexPath.row];
    cell.subtitleLabel.text = @"";
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:[self.statNameData[section] allKeys][0]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMakeRuleView* view = (MPMakeRuleView*) self.view;
    [view.form.nextButton enable];
    self.selectedPath = indexPath;
}

+ (NSString*) statsReuseIdentifier { return @"StatsIdentifier"; }

@end
