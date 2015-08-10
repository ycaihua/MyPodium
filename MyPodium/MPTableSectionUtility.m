//
//  MPTableSectionUtility.m
//  MyPodium
//
//  Created by Connor Neville on 6/28/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTableSectionUtility.h"
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

+ (void) updateCell: (MPTableViewCell*) cell withTeamObject: (PFObject*) team {
    cell.titleLabel.text = team[@"teamName"];
    PFUser* owner = team[@"owner"];
    cell.subtitleLabel.text = [NSString stringWithFormat:@"owner: %@", owner.username];
}

+ (void) updateCell: (MPTableViewCell*) cell withRuleObject:(PFObject *)rule {
    cell.titleLabel.text = rule[@"name"];
    BOOL teamParticipants = [rule[@"usesTeamParticipants"] boolValue];
    if(teamParticipants)
        cell.subtitleLabel.text = @"team vs. team rules";
    else
        cell.subtitleLabel.text = @"player vs. player rules";
}

@end
