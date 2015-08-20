//
//  MPTableSectionUtility.m
//  MyPodium
//
//  Created by Connor Neville on 6/28/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTableSectionUtility.h"

#import "MPFriendsModel.h"

#import "MPTableViewCell.h"
#import "MPLabel.h"

#import <Parse/Parse.h>

@implementation MPTableSectionUtility

- (id) initWithHeaderTitle: (NSString*) headerTitle
             withDataBlock: (NSArray*(^)()) dataBlock
     withCellCreationBlock: (UITableViewCell*(^)(UITableView* table, NSIndexPath* indexPath)) cellCreationBlock
       withCellUpdateBlock: (void(^)(UITableViewCell* cell, id object)) cellUpdateBlock{
    self = [super init];
    if(self) {
        self.headerTitle = headerTitle;
        self.dataBlock = dataBlock;
        self.cellCreationBlock = cellCreationBlock;
        self.cellUpdateBlock = cellUpdateBlock;
    }
    return self;
}

- (void) reloadData {
    self.dataObjects = self.dataBlock();
}

+ (void) updateCell: (MPTableViewCell*) cell withUserObject: (PFUser*) user {
    cell.titleLabel.text = user.username;
    NSString* realName = user[@"realName"];
    if(realName) {
        dispatch_async(dispatch_queue_create("FriendStatusQueue", 0), ^{
            MPFriendStatus status = [MPFriendsModel friendStatusFromUser:user toUser:[PFUser currentUser]];
            BOOL displayName = (status == MPFriendStatusFriends || status == MPFriendStatusSameUser);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(displayName)
                    cell.subtitleLabel.text = realName;
                else
                    cell.subtitleLabel.text = @"";
            });
        });
    }
    else
        cell.subtitleLabel.text = @"";
}

+ (void) updateCell: (MPTableViewCell*) cell withTeamObject: (PFObject*) team {
    cell.titleLabel.text = team[@"name"];
    PFUser* owner = team[@"owner"];
    [owner fetchIfNeededInBackgroundWithBlock:^(PFObject* object, NSError* error) {
        if(!error) {
            cell.subtitleLabel.text = [NSString stringWithFormat:@"owner: %@", owner.username];
        }
        else {
            NSLog(@"%@", error);
        }
    }];
}

+ (void) updateCell: (MPTableViewCell*) cell withRuleObject:(PFObject *)rule {
    cell.titleLabel.text = rule[@"name"];
    BOOL teamParticipants = [rule[@"usesTeamParticipants"] boolValue];
    if(teamParticipants)
        cell.subtitleLabel.text = @"team vs. team rules";
    else
        cell.subtitleLabel.text = @"player vs. player rules";
}

+ (void) updateCell:(MPTableViewCell *)cell withEventObject:(PFObject *)event {
    cell.titleLabel.text = event[@"name"];
    PFObject* rule = event[@"rule"];
    NSString* eventType = [event[@"eventType"] lowercaseString];
    [rule fetchIfNeededInBackgroundWithBlock:^(PFObject* object, NSError* error) {
        if(!error) {
            BOOL teamParticipants = [rule[@"usesTeamParticipants"] boolValue];
            if(teamParticipants)
                cell.subtitleLabel.text = [NSString stringWithFormat:@"team vs. team %@", eventType];
            else
                cell.subtitleLabel.text = [NSString stringWithFormat:@"player vs. player %@", eventType];
        }
        else {
            NSLog(@"%@", error);
        }
    }];
    
}

@end
