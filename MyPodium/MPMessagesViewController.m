//
//  MPFriendsViewController.m
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
#import "CNLabel.h"
#import "MPMessagesCell.h"

#import "MPMessagesViewController.h"
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
        [self loadOnDismiss:self];
    }
    return self;
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
                                [cell.leftButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(markReadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                //[cell.centerButton addTarget:self action:@selector(readMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                //[cell.rightButton addTarget:self action:@selector(deleteMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object];
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
                                [cell.leftButton setImageString:@"up" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(markUnreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                //[cell.centerButton addTarget:self action:@selector(readMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                //[cell.rightButton addTarget:self action:@selector(deleteMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object];
                            }]
                           ];
}

- (void) loadOnDismiss: (id) sender {
    MPMessagesView* view = (MPMessagesView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ReloadQueue", 0);
    dispatch_async(backgroundQueue, ^{
        MPMessagesView* view = (MPMessagesView*) self.view;
        [self refreshData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.messagesTable reloadData];
            [view.loadingHeader removeFromSuperview];
            [view.menu.subtitleLabel displayMessage:[MPMessagesView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
        });
    });
}

- (void) refreshData {
    for(MPTableSectionUtility* section in self.tableSections) {
        [section reloadData];
    }
    [self updateHeaders];
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

- (void) performModelUpdate: (BOOL (^)(void)) methodAction
         withSuccessMessage: (NSString*) successMessage
           withErrorMessage: (NSString*) errorMessage
      withConfirmationAlert: (BOOL) showAlert
    withConfirmationMessage: (NSString*) alertMessage {
    MPMessagesView* view = (MPMessagesView*) self.view;
    
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
                if(success)
                    [self refreshData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //Update UI, based on success
                    if(success) {
                        view.menu.subtitleLabel.persistentText = [MPMessagesView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage: successMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPGreenColor]];
                    }
                    else {
                        view.menu.subtitleLabel.persistentText = [MPMessagesView defaultSubtitle];
                        view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                        [view.menu.subtitleLabel displayMessage:errorMessage
                                                    revertAfter:TRUE
                                                      withColor:[UIColor MPRedColor]];
                    }
                    [view.messagesTable reloadData];
                });
            });
        }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler) {
            [view.menu.subtitleLabel displayMessage:[MPMessagesView defaultSubtitle] revertAfter:false withColor:[UIColor whiteColor]];
            
        }];
        [confirmationAlert addAction: confirmAction];
        [confirmationAlert addAction: cancelAction];
        [self presentViewController: confirmationAlert animated: true completion:nil];
    }
    else {
        dispatch_queue_t backgroundQueue = dispatch_queue_create("ActionQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL success = methodAction();
            if(success)
                [self refreshData];
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(success) {
                    view.menu.subtitleLabel.persistentText = [MPMessagesView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage: successMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPMessagesView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:errorMessage
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                }
                [view.messagesTable reloadData];
            });
        });
    }
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
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:false
     withConfirmationMessage:nil];
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
            withErrorMessage:@"There was an error processing the request."
       withConfirmationAlert:false
     withConfirmationMessage:nil];
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
    [self loadOnDismiss: self];
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