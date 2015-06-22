//
//  MPUserSearchViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"

#import "MPFriendsModel.h"
#import "MPGlobalModel.h"

#import "MPUserSearchView.h"
#import "MPUserCell.h"
#import "MPTableHeader.h"
#import "MPSearchView.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPUserSearchViewController.h"

@interface MPUserSearchViewController ()

@end

@implementation MPUserSearchViewController

- (id) init {
    self = [super init];
    if(self) {
        MPUserSearchView* view = [[MPUserSearchView alloc] init];
        self.view = view;
        //table initUITableView* table = view.friendsTable;
        [self updateUnfilteredHeaders];
        UITableView* table = view.searchTable;
        [table registerClass:[MPUserCell class]
      forCellReuseIdentifier:[MPUserSearchViewController searchReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPUserSearchViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [table reloadData];
        //searchView init
        [view.searchView.searchButton addTarget:self
                                           action:@selector(searchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.searchView.searchField.delegate = self;
    }
    return self;
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPUserSearchViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                [MPUserSearchViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPUserSearchViewController blankReuseIdentifier]];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
    MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPUserSearchViewController searchReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPUserSearchViewController searchReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    
    PFUser* user;
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPUserSearchViewController friendsHeader]]) {
        user = self.matchingFriends[indexPath.row];
    }
    else {
        user = self.matchingUsers[indexPath.row];
    }
    [cell updateForUser: user];
    
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPUserSearchViewController friendsHeader]]) {
        //Update button types on incoming request
        [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
        //Add targets
    }
    else {
        //Update button type - outgoing and friends are same images
        [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
        [cell.rightButton setImageString:@"plus" withColorString:@"yellow" withHighlightedColorString:@"black"];
        //Add targets
        [cell.rightButton addTarget:self action:@selector(addFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (void) removeFriendButtonPressed: (id) sender {
    MPUserSearchView* view = (MPUserSearchView*)self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFUser* other = self.matchingFriends[indexPath.row];
    
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
                NSMutableArray* newMatchingFriends = self.matchingFriends.mutableCopy;
                [newMatchingFriends removeObject: other];
                if(newMatchingFriends.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPUserSearchViewController friendsHeader]];
                self.matchingFriends = newMatchingFriends;
                
                NSMutableArray* newMatchingUsers = self.matchingUsers.mutableCopy;
                [newMatchingUsers addObject:other];
                if(newMatchingUsers.count == 1)
                    [self.sectionHeaderNames addObject:
                     [MPUserSearchViewController usersHeader]];
                self.matchingUsers = newMatchingUsers;
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
                    [view.searchTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error removing the friend. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.searchTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirmRemoveAlert addAction: confirmAction];
    [confirmRemoveAlert addAction: cancelAction];
    [self presentViewController: confirmRemoveAlert animated: true completion:nil];
}

- (void) addFriendButtonPressed: (id) sender {
    MPUserSearchView* view = (MPUserSearchView*)self.view;
    UIButton* buttonSender = (UIButton*) sender;
    MPUserCell* cell = (MPUserCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    
    PFUser* other = self.matchingUsers[indexPath.row];
    
    //Save, because we want to display a message that won't
    //revert after at a given time, but will after execution
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmRemoveAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Send a friend request to %@?", other.username]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("AddFriendQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL addSuccess = [MPFriendsModel sendRequestFromUser:[PFUser currentUser] toUser:other];
            //If accept success, first update controller data
            //from model data
            if(addSuccess) {
                NSMutableArray* newMatchingUsers = self.matchingUsers.mutableCopy;
                [newMatchingUsers removeObject:other];
                if(newMatchingUsers.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPUserSearchViewController usersHeader]];
                self.matchingUsers = newMatchingUsers;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(addSuccess) {
                    view.menu.subtitleLabel.persistentText = [MPUserSearchView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You sent a friend request to %@.", other.username]
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPGreenColor]];
                    [view.searchTable reloadData];
                }
                else {
                    view.menu.subtitleLabel.persistentText = [MPUserSearchView defaultSubtitle];
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:@"There was an error sending the request. Please try again later."
                                                revertAfter:TRUE
                                                  withColor:[UIColor MPRedColor]];
                    [view.searchTable reloadData];
                }
            });
        });
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirmRemoveAlert addAction: confirmAction];
    [confirmRemoveAlert addAction: cancelAction];
    [self presentViewController: confirmRemoveAlert animated: true completion:nil];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:
        [MPUserSearchViewController friendsHeader]]) {
        return self.matchingFriends.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPUserSearchViewController usersHeader]]) {
        return self.matchingUsers.count;
    }
    else {
        return 1;
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

#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    [self searchButtonPressed: nil];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchButtonPressed: nil];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self textFieldShouldClear: textField];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self searchButtonPressed:nil];
    return YES;
}

#pragma mark table headers

- (void) updateUnfilteredHeaders {
    self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
    if(self.matchingFriends.count == 0 && self.matchingUsers.count == 0) {
        [self.sectionHeaderNames addObject:[MPUserSearchViewController noneFoundHeader]];
        return;
    }
    if(self.matchingFriends.count > 0)
        [self.sectionHeaderNames addObject:[MPUserSearchViewController friendsHeader]];
    if(self.matchingUsers.count > 0)
        [self.sectionHeaderNames addObject:[MPUserSearchViewController usersHeader]];
}

#pragma mark button actions

- (void) searchButtonPressed: (id) sender {
    MPUserSearchView* view = (MPUserSearchView*) self.view;
    [self filterDataWithString:view.searchView.searchField.text];
}

- (void) filterDataWithString: (NSString*) string {
    if(string.length == 0) {
        self.matchingFriends = @[];
        self.matchingUsers = @[];
        [self updateUnfilteredHeaders];
        MPUserSearchView* view = (MPUserSearchView*) self.view;
        [view.searchTable reloadData];
        return;
    }
    
    MPUserSearchView* view = (MPUserSearchView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Searching..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    [view.searchView.searchField resignFirstResponder];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
    dispatch_async(backgroundQueue, ^{
        self.matchingFriends = [MPFriendsModel friendsForUser:[PFUser currentUser] containingString:string];
        self.matchingUsers = [MPGlobalModel userSearchContainingString:string forUser:[PFUser currentUser]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUnfilteredHeaders];
            [view.searchTable reloadData];
            [view.menu.subtitleLabel displayMessage:[MPUserSearchView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
        });
    });
}

#pragma mark class methods

+ (NSString*) friendsHeader { return @"FRIENDS"; }
+ (NSString*) usersHeader { return @"OTHER USERS"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }
+ (NSString*) searchReuseIdentifier { return @"userSearchIdentifier"; }
+ (NSString*) blankReuseIdentifier { return @"blankIdentifier"; }

@end
