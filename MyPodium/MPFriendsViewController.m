//
//  MPFriendsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPFriendsModel.h"

#import "MPFriendsView.h"
#import "MPUserCell.h"
#import "MPTableHeader.h"
#import "MPSearchView.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPFriendsViewController.h"

@interface MPFriendsViewController ()

@end

@implementation MPFriendsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPFriendsView* view = [[MPFriendsView alloc] init];
        self.view = view;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        //Data init (in background)
        dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
        dispatch_async(backgroundQueue, ^{
            PFUser* user = [PFUser currentUser];
            self.incomingPendingList = [MPFriendsModel incomingPendingRequestsForUser:user];
            self.outgoingPendingList = [MPFriendsModel outgoingPendingRequestsForUser:user];
            self.friendsList = [MPFriendsModel friendsForUser:user];
            [self updateUnfilteredHeaders];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Table UI init once data is retrieved
                UITableView* table = view.friendsTable;
                [table registerClass:[MPUserCell class]
              forCellReuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
                table.delegate = self;
                table.dataSource = self;
                [view.loadingHeader removeFromSuperview];
                [table reloadData];
            });
        });
    }
    return self;
}

- (void) loadOnDismiss: (id) sender {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ReloadQueue", 0);
    dispatch_async(backgroundQueue, ^{
        MPFriendsView* view = (MPFriendsView*) self.view;
        [self refreshData];
        //Re-filter
        if(self.isFiltered)
            [self filterListsWithString:view.filterSearch.searchField.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.friendsTable reloadData];
        });
    });
}

- (void) refreshData {
    PFUser* user = [PFUser currentUser];
    self.incomingPendingList = [MPFriendsModel incomingPendingRequestsForUser:user];
    self.outgoingPendingList = [MPFriendsModel outgoingPendingRequestsForUser:user];
    self.friendsList = [MPFriendsModel friendsForUser:user];
    [self updateUnfilteredHeaders];
}

- (void) updateUnfilteredHeaders {
    self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
    if(self.incomingPendingList.count > 0)
        [self.sectionHeaderNames addObject:[MPFriendsViewController incomingPendingHeader]];
    if(self.outgoingPendingList.count > 0)
        [self.sectionHeaderNames addObject:[MPFriendsViewController outgoingPendingHeader]];
    if(self.friendsList.count > 0)
        [self.sectionHeaderNames addObject:[MPFriendsViewController friendsHeader]];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                           [MPFriendsViewController friendsReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    
    PFUser* user;
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPFriendsViewController incomingPendingHeader]]) {
        if(self.isFiltered)
            user = self.incomingPendingFilteredList[indexPath.row];
        else
            user = self.incomingPendingList[indexPath.row];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPFriendsViewController outgoingPendingHeader]]) {
        if(self.isFiltered)
            user = self.outgoingPendingFilteredList[indexPath.row];
        else
            user = self.outgoingPendingList[indexPath.row];
    }
    else {
        if(self.isFiltered)
            user = self.friendsFilteredList[indexPath.row];
        else
            user = self.friendsList[indexPath.row];
    }
    //Update data for appropriate user
    [cell updateForUser: user];
    
    //Remove any existing actions
    [cell.leftButton removeTarget:nil
                           action:NULL
                 forControlEvents:UIControlEventAllEvents];
    [cell.rightButton removeTarget:nil
                           action:NULL
                 forControlEvents:UIControlEventAllEvents];
    
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPFriendsViewController incomingPendingHeader]]) {
        //Update button types on incoming request
        [cell.leftButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
        //Add targets
        [cell.leftButton addTarget:self action:@selector(acceptIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightButton addTarget:self action:@selector(denyIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPFriendsViewController outgoingPendingHeader]]) {
        //Update button type - outgoing and friends are same images
        [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
        //Add targets
        [cell.rightButton addTarget:self action:@selector(cancelOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        //Update button type - outgoing and friends are same images
        [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
        //Add targets
        [cell.rightButton addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:
        [MPFriendsViewController incomingPendingHeader]]) {
        if(self.isFiltered)
            return self.incomingPendingFilteredList.count;
        else
            return self.incomingPendingList.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPFriendsViewController outgoingPendingHeader]]) {
        if(self.isFiltered)
            return self.outgoingPendingFilteredList.count;
        else
            return self.outgoingPendingList.count;
    }
    else {
        if(self.isFiltered)
            return self.friendsFilteredList.count;
        else
            return self.friendsList.count;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPUserCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:self.sectionHeaderNames[section]];
}

#pragma mark button actions

- (void) acceptIncomingButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    //Background thread
    dispatch_queue_t backgroundQueue = dispatch_queue_create("AcceptFriendQueue", 0);
    dispatch_async(backgroundQueue, ^{
        
        PFUser* other;
        if(self.isFiltered) {
            other = self.incomingPendingFilteredList[indexPath.row];
        }
        else {
            other = self.incomingPendingList[indexPath.row];
        }
        
        BOOL acceptSuccess = [MPFriendsModel acceptRequestFromUser: other toUser:[PFUser currentUser]];
        //If accept success, first update controller data
        //from model data
        if(acceptSuccess) {
            [self refreshData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update UI, based on success
            if(acceptSuccess) {
                view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:
                                                         @"You accepted a friend request from %@.", other.username]
                                            revertAfter:TRUE
                                              withColor:[UIColor MPGreenColor]];
                [view.friendsTable reloadData];
            }
            else {
                view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                [view.menu.subtitleLabel displayMessage:@"There was an error accepting the request. Please try again later."
                                            revertAfter:TRUE
                                              withColor:[UIColor MPRedColor]];
                [view.friendsTable reloadData];
            }
        });
    });
}

- (void) denyIncomingButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFUser* other;
    if(self.isFiltered) {
        other = self.incomingPendingFilteredList[indexPath.row];
    }
    else {
        other = self.incomingPendingList[indexPath.row];
    }
    
    //Save, because we want to display a message that won't
    //revert after at a given time, but will after execution
    NSString* defaultTitle = view.menu.subtitleLabel.text;
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmDenyAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to deny the friend request from %@?", other.username]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("DenyFriendQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL denySuccess = [MPFriendsModel removeRequestFromUser: other toUser:[PFUser currentUser]];
            //If accept success, first update controller data
            //from model data
            if(denySuccess) {
                [self refreshData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(denySuccess) {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You denied a friend request from %@.", other.username]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.friendsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error denying the request. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.friendsTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler){
        [view.menu.subtitleLabel displayMessage:defaultTitle
                                    revertAfter:FALSE
                                      withColor:[UIColor whiteColor]];
    }];
    [confirmDenyAlert addAction: confirmAction];
    [confirmDenyAlert addAction: cancelAction];
    [self presentViewController: confirmDenyAlert animated: true completion:nil];
}

- (void) cancelOutgoingButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFUser* other;
    if(self.isFiltered) {
        other = self.outgoingPendingFilteredList[indexPath.row];
    }
    else {
        other = self.outgoingPendingList[indexPath.row];
    }
    
    //Save, because we want to display a message that won't
    //revert after at a given time, but will after execution
    NSString* defaultTitle = view.menu.subtitleLabel.text;
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmCancelAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to cancel your friend request to %@?", other.username]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("CancelFriendQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL cancelSuccess = [MPFriendsModel removeRequestFromUser: [PFUser currentUser] toUser:other];
            //If accept success, first update controller data
            //from model data
            if(cancelSuccess) {
                [self refreshData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(cancelSuccess) {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You cancelled your friend request to %@.", other.username]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.friendsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error cancelling the request. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.friendsTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler){
        [view.menu.subtitleLabel displayMessage:defaultTitle
                                    revertAfter:FALSE
                                      withColor:[UIColor whiteColor]];
    }];
    [confirmCancelAlert addAction: confirmAction];
    [confirmCancelAlert addAction: cancelAction];
    [self presentViewController: confirmCancelAlert animated: true completion:nil];
}

- (void) removeFriendButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFUser* other;
    if(self.isFiltered) {
        other = self.friendsFilteredList[indexPath.row];
    }
    else {
        other = self.friendsList[indexPath.row];
    }
    
    //Save, because we want to display a message that won't
    //revert after at a given time, but will after execution
    NSString* defaultTitle = view.menu.subtitleLabel.text;
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmRemoveAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to remove %@ as a friend?", other.username]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("RemoveFriendQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL removeSuccess = [MPFriendsModel removeFriendRelationWithFirstUser:other secondUser:[PFUser currentUser]];
            //If accept success, first update controller data
            //from model data
            if(removeSuccess) {
                [self refreshData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(removeSuccess) {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You removed %@ as a friend.", other.username]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.friendsTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error removing the friend. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.friendsTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* handler){
        [view.menu.subtitleLabel displayMessage:defaultTitle
                                    revertAfter:FALSE
                                      withColor:[UIColor whiteColor]];
    }];
    [confirmRemoveAlert addAction: confirmAction];
    [confirmRemoveAlert addAction: cancelAction];
    [self presentViewController: confirmRemoveAlert animated: true completion:nil];
}

#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    [view.filterSearch.searchField resignFirstResponder];
    NSString* filterString = view.filterSearch.searchField.text;
    if(filterString.length == 0) {
        self.isFiltered = NO;
        [self updateUnfilteredHeaders];
        [view.friendsTable reloadData];
        return;
    }
    [self filterListsWithString: filterString];
    [view.friendsTable reloadData];
}

- (void) filterListsWithString: (NSString*) filterString {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FilterQueue", 0);
    dispatch_async(backgroundQueue, ^{
        self.isFiltered = YES;
        self.incomingPendingFilteredList = [[NSMutableArray alloc] initWithCapacity:
                                            self.incomingPendingList.count];
        self.outgoingPendingFilteredList = [[NSMutableArray alloc] initWithCapacity:
                                            self.outgoingPendingList.count];
        self.friendsFilteredList = [[NSMutableArray alloc] initWithCapacity:
                                    self.friendsList.count];
        
        MPFriendsView* view = (MPFriendsView*) self.view;
        [view.menu.subtitleLabel displayMessage:@"Filtering..." revertAfter:NO withColor:[UIColor MPYellowColor]];
        
        //Filter incoming pending
        for (PFUser* user in self.incomingPendingList)
        {
            NSString* username = user.username;
            NSString* realName = user[@"realName"];
            if(!realName) realName = @"";
            NSRange usernameRange = [username rangeOfString:filterString options:NSCaseInsensitiveSearch];
            NSRange realNameRange = [realName rangeOfString:filterString options:NSCaseInsensitiveSearch];
            if(usernameRange.location != NSNotFound || realNameRange.location != NSNotFound)
            {
                [self.incomingPendingFilteredList addObject:user];
            }
        }
        if(self.incomingPendingFilteredList.count == 0)
            [self.sectionHeaderNames removeObject:[MPFriendsViewController incomingPendingHeader]];
        
        //Filter outgoing pending
        for (PFUser* user in self.outgoingPendingList)
        {
            NSString* username = user.username;
            NSString* realName = user[@"realName"];
            if(!realName) realName = @"";
            NSRange usernameRange = [username rangeOfString:filterString options:NSCaseInsensitiveSearch];
            NSRange realNameRange = [realName rangeOfString:filterString options:NSCaseInsensitiveSearch];
            if(usernameRange.location != NSNotFound || realNameRange.location != NSNotFound)
            {
                [self.outgoingPendingFilteredList addObject:user];
            }
        }
        if(self.outgoingPendingFilteredList.count == 0)
            [self.sectionHeaderNames removeObject:[MPFriendsViewController outgoingPendingHeader]];
        
        //Filter friends
        for (PFUser* user in self.friendsList)
        {
            NSString* username = user.username;
            NSString* realName = user[@"realName"];
            if(!realName) realName = @"";
            NSRange usernameRange = [username rangeOfString:filterString options:NSCaseInsensitiveSearch];
            NSRange realNameRange = [realName rangeOfString:filterString options:NSCaseInsensitiveSearch];
            if(usernameRange.location != NSNotFound || realNameRange.location != NSNotFound)
            {
                [self.friendsFilteredList addObject:user];
            }
        }
        if(self.friendsFilteredList.count == 0)
            [self.sectionHeaderNames removeObject:[MPFriendsViewController friendsHeader]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.friendsTable reloadData];
            [view.menu.subtitleLabel displayMessage:[MPFriendsView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
        });
    });
}

#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    self.isFiltered = NO;
    [self updateUnfilteredHeaders];
    MPFriendsView* view = (MPFriendsView*) self.view;
    [view.friendsTable reloadData];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self filterSearchButtonPressed: nil];
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

+ (NSString*) incomingPendingHeader { return @"INCOMING FRIEND REQUESTS"; }
+ (NSString*) outgoingPendingHeader { return @"OUTGOING FRIEND REQUESTS"; }
+ (NSString*) friendsHeader { return @"MY FRIENDS"; }
+ (NSString*) friendsReuseIdentifier { return @"FriendsCell"; }
@end
