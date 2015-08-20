//
//  MPRulesViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPRulesModel.h"
#import "MPGlobalModel.h"

#import "MPRulesView.h"
#import "MPTableViewCell.h"
#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPRulesViewController.h"
#import "MPRuleProfileViewController.h"
#import "MPMakeRuleViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPRulesViewController ()

@end

@implementation MPRulesViewController

- (id) init {
    self = [super init];
    if(self) {
        MPRulesView* view = [[MPRulesView alloc] init];
        self.view = view;
        self.delegate = self;
        [view startLoading];
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeControlActions];
        [self makeTableSections];
        UITableView* table = view.rulesTable;
        [table registerClass:[MPTableViewCell class]
      forCellReuseIdentifier:[MPRulesViewController rulesReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPRulesViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [self reloadData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPRulesViewController ownedRulesHeader]
                            withDataBlock:^(){
                                NSArray* ownedRules = [MPRulesModel rulesForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPRulesView* view = (MPRulesView*) self.view;
                                    return [MPGlobalModel rulesList:ownedRules searchForString:view.filterSearch.searchField.text];
                                }
                                else return ownedRules;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPRulesViewController rulesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPRulesViewController rulesReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:3];
                                [cell clearButtonActions];
                                [cell setButtonImageStrings:@[@[@"plus", @"green"], @[@"info", @"yellow"], @[@"x", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[2] addTarget:self action:@selector(newEventWithRuleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[1] addTarget:self action:@selector(ruleProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(deleteRuleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withRuleObject:object];
                            }]
                           ];
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPRulesViewController* rulesVC = (MPRulesViewController*) controller;
    for(MPTableSectionUtility* section in rulesVC.tableSections) {
        [section reloadData];
    }
    [rulesVC updateHeaders];
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPRulesViewController* rulesVC = (MPRulesViewController*) controller;
    MPRulesView* view = (MPRulesView*) rulesVC.view;
    return view.rulesTable;
}

- (void) updateHeaders {
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPRulesViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

- (void) makeControlActions {
    MPRulesView* view = (MPRulesView*) self.view;
    [view.searchButton addTarget: self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.makeRuleButton addTarget:self action:@selector(makeRuleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) searchButtonPressed: (id) sender {
    MPRulesView* view = (MPRulesView*) self.view;
    if(view.searchAvailable) {
        [view hideSearch];
    }
    else {
        [view displaySearch];
    }
}

- (void) makeRuleButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMakeRuleViewController alloc] init] fromController:self];
}

#pragma mark cell targets

- (void) newEventWithRuleButtonPressed: (id) sender {
    NSLog(@"Green button");
}

- (void) ruleProfileButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPRulesViewController ownedRulesHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPRuleProfileViewController alloc] initWithRule:other] fromController:self];
}

- (void) deleteRuleButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPRulesViewController ownedRulesHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPRulesModel deleteRule:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your rule, %@.", other[@"name"]]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to delete your rule, %@?", other[@"name"]]
      shouldShowConfirmation:showConfirmation];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPRulesViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPRulesViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPRulesViewController blankReuseIdentifier]];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }
    else {
        NSString* sectionHeader = self.sectionHeaderNames[indexPath.section];
        MPTableSectionUtility* section = [self tableSectionWithHeader: sectionHeader];
        UITableViewCell* cell = section.cellCreationBlock(tableView, indexPath);
        id object = section.dataObjects[indexPath.row];
        section.cellUpdateBlock(cell, object);
        return cell;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:[MPRulesViewController noneFoundHeader]])
        return 1;
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.sectionHeaderNames[section]];
    return  sectionUtility.dataObjects.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:self.sectionHeaderNames[section]];
}

- (MPTableSectionUtility*) tableSectionWithHeader: (NSString*) header {
    for(MPTableSectionUtility* section in self.tableSections) {
        if([section.headerTitle isEqualToString: header])
            return section;
    }
    return nil;
}

#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPRulesView* view = (MPRulesView*) self.view;
    [view.filterSearch.searchField resignFirstResponder];
    NSString* filterString = view.filterSearch.searchField.text;
    self.isFiltered = !(filterString.length == 0);
    [self reloadData];
}


#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self textFieldShouldClear: textField];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self filterSearchButtonPressed:nil];
    return YES;
}

#pragma mark constants


+ (NSString*) ownedRulesHeader { return @"MY RULES"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) rulesReuseIdentifier { return @"ModesCell"; }
+ (NSString*) blankReuseIdentifier { return @"BlankCell"; }
@end
