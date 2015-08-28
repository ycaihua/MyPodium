//
//  MPMakeEventRuleHandler.m
//  MyPodium
//
//  Created by Connor Neville on 8/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>
#import "MPTableSectionUtility.h"

#import "MPRulesModel.h"

#import "MPTableViewCell.h"
#import "MPTableHeader.h"
#import "MPEventTypeView.h"

#import "MPMakeEventRuleHandler.h"

@implementation MPMakeEventRuleHandler

- (id) initWithEventType: (MPEventType) type {
    self = [super init];
    if(self) {
        self.eligibleRules = [self generateEligibleRulesForEventType:type];
        NSLog(@"%lu", (unsigned long)self.eligibleRules.count);
    }
    return self;
}

- (NSArray*) generateEligibleRulesForEventType: (MPEventType) eventType {
    if(eventType == MPEventTypeLeague || eventType == MPEventTypeTournament)
        return [MPRulesModel rulesForUserWith2ParticipantsPerMatch:[PFUser currentUser]];
    else return [MPRulesModel rulesForUser:[PFUser currentUser]];
}

- (UITableViewCell*) tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                             [MPMakeEventRuleHandler ruleReuseIdentifier] forIndexPath:indexPath];
    
    if(!cell)
        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeEventRuleHandler ruleReuseIdentifier]];
    
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
    return [[MPTableHeader alloc] initWithText:@"FRIENDS"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

+ (NSString*) ruleReuseIdentifier { return @"RuleCell"; }

@end
