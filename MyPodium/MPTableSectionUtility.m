//
//  MPTableSectionUtility.m
//  MyPodium
//
//  Created by Connor Neville on 6/28/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTableSectionUtility.h"

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
        [self reloadData];
    }
    return self;
}

- (void) reloadData {
    self.dataObjects = self.dataBlock();
}

@end
