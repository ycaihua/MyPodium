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
                [self.sectionHeaderNames addObject:@"INCOMING REQUESTS"];
            
            self.outgoingPendingList = [MPFriendsModel outgoingPendingRequestsForUser:user];
            if(self.outgoingPendingList.count > 0)
                [self.sectionHeaderNames addObject:@"OUTGOING REQUESTS"];
            
            self.friendsList = [MPFriendsModel friendsForUser:user];
            if(self.friendsList.count > 0)
                [self.sectionHeaderNames addObject:@"MY FRIENDS"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableView* table = view.friendsTable;
                [table registerClass:[MPFriendsCell class]
              forCellReuseIdentifier:[MPFriendsViewController sidebarReuseIdentifier]];
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
                           [MPFriendsViewController sidebarReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPFriendsViewController sidebarReuseIdentifier]];
    }
    
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:@"INCOMING REQUESTS"]) {
        [cell updateForIncomingRequest];
        [cell updateForUser: self.incomingPendingList[indexPath.row]];
    }
    else if([self.sectionHeaderNames[indexPath.section] isEqualToString:@"OUTGOING REQUESTS"]) {
        [cell updateForUser: self.outgoingPendingList[indexPath.row]];
    }
    else {
        [cell updateForUser: self.friendsList[indexPath.row]];
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:@"INCOMING REQUESTS"]) {
        return self.incomingPendingList.count;
    }
    else if([self.sectionHeaderNames[section] isEqualToString:@"OUTGOING REQUESTS"]) {
        return self.outgoingPendingList.count;
    }
    else {
        return self.friendsList.count;
    }

    
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

+ (NSString*) sidebarReuseIdentifier { return @"FriendsCell"; }
@end
