//
//  MPEventsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPEventsModel.h"
#import "MPGlobalModel.h"

#import "MPEventsView.h"
#import "MPTableViewCell.h"
#import "MPBottomEdgeButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPEventsViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPEventsViewController ()

@end

@implementation MPEventsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPEventsView* view = [[MPEventsView alloc] init];
        self.view = view;
        self.delegate = self;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeControlActions];
        [self makeTableSections];
        UITableView* table = view.eventsTable;
        [table registerClass:[MPTableViewCell class]
      forCellReuseIdentifier:[MPEventsViewController eventsReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPEventsViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [self reloadData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPEventsViewController ownedEventsHeader]
                            withDataBlock:^(){
                                NSArray* ownedEvents = [MPEventsModel eventsOwnedByUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPEventsView* view = (MPEventsView*) self.view;
                                    return [MPGlobalModel eventList:ownedEvents searchForString:view.filterSearch.searchField.text];
                                }
                                else return ownedEvents;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                         [MPEventsViewController eventsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPEventsViewController eventsReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"], @[@"x", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(ownedEventProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(deleteOwnedEventButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withEventObject:object];
                            }],
                           ];
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPEventsViewController* eventsVC = (MPEventsViewController*) controller;
    for(MPTableSectionUtility* section in eventsVC.tableSections) {
        [section reloadData];
    }
    [eventsVC updateHeaders];
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPEventsViewController* eventsVC = (MPEventsViewController*) controller;
    MPEventsView* view = (MPEventsView*)eventsVC.view;
    return view.eventsTable;
}

- (void) updateHeaders {
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPEventsViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

- (void) makeControlActions {
    MPEventsView* view = (MPEventsView*) self.view;
    [view.searchButton addTarget: self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.makeEventButton addTarget:self action:@selector(makeEventButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) searchButtonPressed: (id) sender {
    MPEventsView* view = (MPEventsView*) self.view;
    if(view.searchAvailable) {
        [view hideSearch];
    }
    else {
        [view displaySearch];
    }
}

- (void) makeEventButtonPressed: (id) sender {
    NSLog(@"Make event");
}

#pragma mark cell targets

- (void) ownedEventProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPEventsViewController ownedEventsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    //[MPControllerManager presentViewController:[[MPEventProfileViewController alloc] initWithEvent:other] fromController:self];
    NSLog(@"Event profile for %@", other[@"name"]);
}

- (void) deleteOwnedEventButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPEventsViewController ownedEventsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    
    [self performModelUpdate:^BOOL{
        return [MPEventsModel deleteEvent: other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your event, %@.", other[@"name"]]
            withErrorMessage:@"There was an error processing the request. Please try again later"
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to delete your event, %@? All stats will be lost, and this cannot be undone.", other[@"name"]]];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPEventsViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPEventsViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPEventsViewController blankReuseIdentifier]];
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
    if([self.sectionHeaderNames[section] isEqualToString:[MPEventsViewController noneFoundHeader]])
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
    MPEventsView* view = (MPEventsView*) self.view;
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


+ (NSString*) ownedEventsHeader { return @"OWNED EVENTS"; }
+ (NSString*) participatingEventsHeader { return @"EVENTS I'M PARTICIPATING IN"; }
+ (NSString*) eventsInvitingHeader { return @"EVENTS INVITING ME"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) eventsReuseIdentifier { return @"EventsCell"; }
+ (NSString*) blankReuseIdentifier { return @"BlankCell"; }
@end