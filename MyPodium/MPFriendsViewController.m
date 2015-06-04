//
//  MPFriendsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsViewController.h"
#import "MPFriendsView.h"
#import "MPFriendsCell.h"
#import "MPFriendsHeader.h"
#import "MPFriendsModel.h"
#import "UIColor+MPColor.h"

@interface MPFriendsViewController ()

@end

@implementation MPFriendsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPFriendsView* view = [[MPFriendsView alloc] init];
        self.view = view;
        dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
        dispatch_async(backgroundQueue, ^{
            self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
            PFUser* user = [PFUser currentUser];
            self.incomingPendingList = [MPFriendsModel incomingPendingRequestsForUser:user];
            if(self.incomingPendingList.count > 0)
                [self.sectionHeaderNames addObject:[MPFriendsViewController incomingPendingHeader]];
            
            self.outgoingPendingList = [MPFriendsModel outgoingPendingRequestsForUser:user];
            if(self.outgoingPendingList.count > 0)
                [self.sectionHeaderNames addObject:[MPFriendsViewController outgoingPendingHeader]];
            
            self.friendsList = [MPFriendsModel friendsForUser:user];
            if(self.friendsList.count > 0)
                [self.sectionHeaderNames addObject:[MPFriendsViewController friendsHeader]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableView* table = view.friendsTable;
                [table registerClass:[MPFriendsCell class]
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

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPFriendsCell* cell = [tableView dequeueReusableCellWithIdentifier:
                           [MPFriendsViewController friendsReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController friendsReuseIdentifier]];
    }
    
    cell.greenButton.indexPath = indexPath;
    cell.redButton.indexPath = indexPath;
    
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPFriendsViewController incomingPendingHeader]]) {
        //Update button types on incoming request
        [cell updateForIncomingRequest];
        //Update data for appropriate user
        [cell updateForUser: self.incomingPendingList[indexPath.row]];
        //Add targets
        [cell.greenButton addTarget:self action:@selector(acceptIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.redButton addTarget:self action:@selector(denyIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:
             [MPFriendsViewController outgoingPendingHeader]]) {
        //Update button type - outgoing and friends are same images
        [cell updateForFriendOrOutgoingRequest];
        //Update data for appropriate user
        [cell updateForUser: self.outgoingPendingList[indexPath.row]];
        //Add targets
        [cell.redButton addTarget:self action:@selector(cancelOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        //Update button type - outgoing and friends are same images
        [cell updateForFriendOrOutgoingRequest];
        //Update data for appropriate user
        [cell updateForUser: self.friendsList[indexPath.row]];
        //Add targets
        [cell.redButton addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:
        [MPFriendsViewController incomingPendingHeader]]) {
        return self.incomingPendingList.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:
             [MPFriendsViewController outgoingPendingHeader]]) {
        return self.outgoingPendingList.count;
    }
    else {
        return self.friendsList.count;
    }
}

- (void) acceptIncomingButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    MPFriendsButton* buttonSender = (MPFriendsButton*) sender;
    NSIndexPath* indexPath = buttonSender.indexPath;
    
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    //Background thread
    dispatch_queue_t backgroundQueue = dispatch_queue_create("AcceptFriendQueue", 0);
    dispatch_async(backgroundQueue, ^{
        PFUser* sender = self.incomingPendingList[indexPath.row];
        BOOL acceptSuccess = [MPFriendsModel acceptRequestFromUser: sender toUser:[PFUser currentUser]];
        //If accept success, first update controller data
        //from model data
        if(acceptSuccess) {
            NSMutableArray* newIncomingList = self.incomingPendingList.mutableCopy;
            [newIncomingList removeObject: sender];
            if(newIncomingList.count == 0)
                [self.sectionHeaderNames removeObject:
                 [MPFriendsViewController incomingPendingHeader]];
            self.incomingPendingList = newIncomingList;
            
            NSMutableArray* newFriends = self.friendsList.mutableCopy;
            [newFriends addObject: sender];
            if(newFriends.count == 1) {
                [self.sectionHeaderNames addObject:
                 [MPFriendsViewController friendsHeader]];
            }
            self.friendsList = newFriends;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update UI, based on success
            if(acceptSuccess) {
                view.menu.subtitleLabel.persistentText = [MPFriendsView defaultSubtitle];
                view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                [view.menu.subtitleLabel displayMessage:[NSString stringWithFormat:
                                                         @"You accepted a friend request from %@.", sender.username]
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
    MPFriendsButton* buttonSender = (MPFriendsButton*) sender;
    NSIndexPath* indexPath = buttonSender.indexPath;
    PFUser* userSender = self.incomingPendingList[indexPath.row];
    
    //Save, because we want to display a message that won't
    //revert after at a given time, but will after execution
    NSString* defaultTitle = view.menu.subtitleLabel.text;
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmDenyAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to deny the friend request from %@?", userSender.username]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("DenyFriendQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL denySuccess = [MPFriendsModel removeRequestFromUser: userSender toUser:[PFUser currentUser]];
            //If accept success, first update controller data
            //from model data
            if(denySuccess) {
                NSMutableArray* newIncomingList = self.incomingPendingList.mutableCopy;
                [newIncomingList removeObject: userSender];
                if(newIncomingList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPFriendsViewController incomingPendingHeader]];
                self.incomingPendingList = newIncomingList;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(denySuccess) {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You denied a friend request from %@.", userSender.username]
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
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirmDenyAlert addAction: confirmAction];
    [confirmDenyAlert addAction: cancelAction];
    [self presentViewController: confirmDenyAlert animated: true completion:nil];
}

- (void) cancelOutgoingButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    MPFriendsButton* buttonSender = (MPFriendsButton*) sender;
    NSIndexPath* indexPath = buttonSender.indexPath;
    PFUser* receiver = self.outgoingPendingList[indexPath.row];
    
    //Save, because we want to display a message that won't
    //revert after at a given time, but will after execution
    NSString* defaultTitle = view.menu.subtitleLabel.text;
    [view.menu.subtitleLabel displayMessage:@"Loading..."
                                revertAfter:FALSE
                                  withColor:[UIColor MPYellowColor]];
    
    UIAlertController* confirmCancelAlert =
    [UIAlertController alertControllerWithTitle:@"Confirmation"
                                        message:[NSString stringWithFormat:@"Are you sure you want to cancel your friend request to %@?", receiver.username]
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
        //Background thread
        dispatch_queue_t backgroundQueue = dispatch_queue_create("CancelFriendQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL denySuccess = [MPFriendsModel removeRequestFromUser: [PFUser currentUser] toUser:receiver];
            //If accept success, first update controller data
            //from model data
            if(denySuccess) {
                NSMutableArray* newOutgoingList = self.outgoingPendingList.mutableCopy;
                [newOutgoingList removeObject: receiver];
                if(newOutgoingList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPFriendsViewController outgoingPendingHeader]];
                self.incomingPendingList = newOutgoingList;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Update UI, based on success
                if(denySuccess) {
                    view.menu.subtitleLabel.persistentText = defaultTitle;
                    view.menu.subtitleLabel.textColor = [UIColor whiteColor];
                    [view.menu.subtitleLabel displayMessage:
                     [NSString stringWithFormat: @"You cancelled your friend request to %@.", receiver.username]
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
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirmCancelAlert addAction: confirmAction];
    [confirmCancelAlert addAction: cancelAction];
    [self presentViewController: confirmCancelAlert animated: true completion:nil];
}

- (void) removeFriendButtonPressed: (id) sender {
    MPFriendsView* view = (MPFriendsView*) self.view;
    MPFriendsButton* buttonSender = (MPFriendsButton*) sender;
    NSIndexPath* indexPath = buttonSender.indexPath;
    PFUser* other = self.friendsList[indexPath.row];
    
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
                NSMutableArray* newFriendsList = self.friendsList.mutableCopy;
                [newFriendsList removeObject: other];
                if(newFriendsList.count == 0)
                    [self.sectionHeaderNames removeObject:
                     [MPFriendsViewController friendsHeader]];
                self.friendsList = newFriendsList;
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
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [confirmRemoveAlert addAction: confirmAction];
    [confirmRemoveAlert addAction: cancelAction];
    [self presentViewController: confirmRemoveAlert animated: true completion:nil];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPFriendsCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPFriendsHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPFriendsHeader alloc] initWithText:self.sectionHeaderNames[section]];
}

+ (NSString*) incomingPendingHeader { return @"INCOMING FRIEND REQUESTS"; }
+ (NSString*) outgoingPendingHeader { return @"OUTGOING FRIEND REQUESTS"; }
+ (NSString*) friendsHeader { return @"MY FRIENDS"; }
+ (NSString*) friendsReuseIdentifier { return @"FriendsCell"; }
@end
