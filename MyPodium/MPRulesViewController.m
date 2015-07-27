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
#import "MPRuleCell.h"
#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPRulesViewController.h"
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
        [view startLoading];
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeControlActions];
        [self makeTableSections];
        UITableView* table = view.modesTable;
        [table registerClass:[MPRuleCell class]
      forCellReuseIdentifier:[MPRulesViewController rulesReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPRulesViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [self refreshData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPRulesViewController ownedRulesHeader]
                            withDataBlock:^(){
                                NSArray* ownedModes = [MPRulesModel rulesForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPRulesView* view = (MPRulesView*) self.view;
                                    return [MPGlobalModel modesList:ownedModes searchForString:view.filterSearch.searchField.text];
                                }
                                else return ownedModes;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPRuleCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPRulesViewController rulesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPRulesViewController rulesReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell showLeftButton];
                                [cell.leftButton setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(newEventWithModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(modeProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(deleteModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPRuleCell*)cell updateForRule:object];
                            }]
                           ];
}

- (void) loadOnDismiss: (id) sender {
    MPRulesView* view = (MPRulesView*) self.view;
    [view startLoading];
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ReloadQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* section in self.tableSections) {
            [section reloadData];
        }
        [self updateHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.modesTable reloadData];
            [view finishLoading];
        });
    });
}

- (void) refreshData {
    MPRulesView* view = (MPRulesView*) self.view;
    dispatch_queue_t backgroundQueue = dispatch_queue_create("RefreshQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* section in self.tableSections) {
            [section reloadData];
        }
        [self updateHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.modesTable reloadData];
            [view finishLoading];
        });
    });
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

- (void) performModelUpdate: (BOOL (^)(void)) methodAction
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
      withConfirmationAlert: (BOOL) showAlert
    withConfirmationMessage: (NSString*) alertMessage {
    MPRulesView* view = (MPRulesView*) self.view;
    [view startLoading];
    if(showAlert) {
        UIAlertController* confirmationAlert =
        [UIAlertController alertControllerWithTitle:@"Confirmation"
                                            message:alertMessage
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
            //Background thread
            dispatch_queue_t backgroundQueue = dispatch_queue_create("ActionQueue", 0);
            dispatch_async(backgroundQueue, ^{
                BOOL success = methodAction();
                dispatch_async(dispatch_get_main_queue(), ^{
                    //Update UI, based on success
                    if(success) {
                        view.menu.subtitleLabel.persistentText = [MPRulesView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                        [self refreshData];
                        [view.modesTable reloadData];
                    }
                    else {
                        view.menu.subtitleLabel.persistentText = [MPRulesView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                    }
                });
            });
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
            [view.menu.subtitleLabel displayMessage:[MPRulesView defaultSubtitle] revertAfter:false withColor:[UIColor whiteColor]];
            
        }];
        [confirmationAlert addAction: confirmAction];
        [confirmationAlert addAction: cancelAction];
        [self presentViewController: confirmationAlert animated: true completion:nil];
    }
    else {
        dispatch_queue_t backgroundQueue = dispatch_queue_create("ActionQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL success = methodAction();
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(success) {
                    view.menu.subtitleLabel.persistentText = [MPRulesView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage: successMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [self refreshData];
                    [view.modesTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPRulesView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                }
            });
        });
    }
}

- (void) newEventWithModeButtonPressed: (id) sender {
    NSLog(@"Green button");
}

- (void) modeProfileButtonPressed: (id) sender {
    NSLog(@"Yellow button");
}

- (void) deleteModeButtonPressed: (id) sender {
    NSLog(@"Red button");
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
    return [MPRuleCell cellHeight];
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
    [self refreshData];
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
