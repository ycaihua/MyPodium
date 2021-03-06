//
//  MPMessagesViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPGlobalModel.h"
#import "MPMessagesModel.h"

#import "MPMessagesView.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"
#import "MPMessagesCell.h"
#import "MPBottomEdgeButton.h"

#import "MPMessagesViewController.h"
#import "MPMessageReaderViewController.h"
#import "MPMessageComposerViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPMessagesViewController ()

@end

@implementation MPMessagesViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMessagesView* view = [[MPMessagesView alloc] init];
        self.view = view;
        self.delegate = self;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeTableSections];
        UITableView* table = view.messagesTable;
        [table registerClass:[MPMessagesCell class]
      forCellReuseIdentifier:[MPMessagesViewController messagesReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPMessagesViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [self makeControlActions];
        [self reloadData];
    }
    return self;
}

- (void) makeControlActions {
    MPMessagesView* view = (MPMessagesView*) self.view;
    [view.composeButton addTarget:self action:@selector(composeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) composeButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMessageComposerViewController alloc] init] fromController:self];
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPMessagesViewController newMessagesHeader]
                            withDataBlock:^(){
                                NSArray* messages = [MPMessagesModel newMessagesForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPMessagesView* view = (MPMessagesView*) self.view;
                                    return [MPGlobalModel messagesList:messages searchForString:view.filterSearch.searchField.text];
                                }
                                else return messages;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPMessagesCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPMessagesViewController messagesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPMessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMessagesViewController messagesReuseIdentifier]];
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
                                [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"check" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(readNewMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(markReadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(deleteNewMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object displaySender: YES];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPMessagesViewController readMessagesHeader]
                            withDataBlock:^(){
                                NSArray* messages = [MPMessagesModel readMessagesForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPMessagesView* view = (MPMessagesView*) self.view;
                                    return [MPGlobalModel messagesList:messages searchForString:view.filterSearch.searchField.text];
                                }
                                else return messages;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPMessagesCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                        [MPMessagesViewController messagesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPMessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMessagesViewController messagesReuseIdentifier]];
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
                                [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"up" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(rereadMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(markUnreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(deleteReadMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object displaySender: YES];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPMessagesViewController sentMessagesHeader]
                            withDataBlock:^(){
                                NSArray* messages = [MPMessagesModel sentMessagesForUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPMessagesView* view = (MPMessagesView*) self.view;
                                    return [MPGlobalModel messagesList:messages searchForString:view.filterSearch.searchField.text];
                                }
                                else return messages;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPMessagesCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                        [MPMessagesViewController messagesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPMessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMessagesViewController messagesReuseIdentifier]];
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
                                [cell hideLeftButton];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.centerButton addTarget:self action:@selector(readSentMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(hideSentMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object displaySender:NO];
                            }]
                           ];
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPMessagesViewController* messagesVC = (MPMessagesViewController*)controller;
    for(MPTableSectionUtility* section in messagesVC.tableSections) {
        [section reloadData];
    }
    [messagesVC updateHeaders];
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPMessagesViewController* messagesVC = (MPMessagesViewController*)controller;
    return ((MPMessagesView*)messagesVC.view).messagesTable;
}

- (void) updateHeaders {
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPMessagesViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

#pragma mark cell targets

- (void) readNewMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController newMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPMessageReaderViewController alloc] initWithMessage:other] fromController:self];
}

- (void) markReadButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController newMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel markMessageRead: other];
    }
          withSuccessMessage:@"You marked the message as read."
            withErrorMessage:@"There was an error processing the request."];
}

- (void) deleteNewMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController newMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel deleteMessage: other];
    }
          withSuccessMessage:@"You deleted the message."
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:@"Are you sure you want to permanently delete this message?"
      shouldShowConfirmation:showConfirmation];
}

- (void) rereadMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController readMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPMessageReaderViewController alloc] initWithMessage:other] fromController:self];
}

- (void) markUnreadButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController readMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel markMessageUnread: other];
    }
          withSuccessMessage:@"You marked the message as unread."
            withErrorMessage:@"There was an error processing the request."];
}

- (void) deleteReadMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController readMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel deleteMessage: other];
    }
          withSuccessMessage:@"You deleted the message."
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:@"Are you sure you want to permanently delete this message?"
      shouldShowConfirmation:showConfirmation];
}

- (void) readSentMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController sentMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPMessageReaderViewController alloc] initWithMessage:other] fromController:self];
}

- (void) hideSentMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPMessagesViewController sentMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel hideMessageFromSender: other];
    }
          withSuccessMessage:@"You removed the message from your sent box."
            withErrorMessage:@"There was an error processing the request."];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPMessagesViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPMessagesViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMessagesViewController blankReuseIdentifier]];
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
    if([self.sectionHeaderNames[section] isEqualToString:[MPMessagesViewController noneFoundHeader]])
        return 1;
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.sectionHeaderNames[section]];
    return  sectionUtility.dataObjects.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPMessagesCell cellHeight];
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

#pragma mark button actions


#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPMessagesView* view = (MPMessagesView*) self.view;
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

+ (NSString*) newMessagesHeader { return @"NEW MESSAGES"; }
+ (NSString*) readMessagesHeader { return @"READ MESSAGES"; }
+ (NSString*) sentMessagesHeader { return @"SENT MESSAGES"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) messagesReuseIdentifier { return @"MessagesCell"; }
+ (NSString*) blankReuseIdentifier { return @"BlankCell"; }
@end