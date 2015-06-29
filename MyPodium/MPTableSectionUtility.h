//
//  MPTableSectionUtility.h
//  MyPodium
//
//  Created by Connor Neville on 6/28/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPTableSectionUtility : NSObject

@property NSString* headerTitle;
@property NSArray* dataObjects;
@property (nonatomic, copy) NSArray* (^dataBlock)();
@property (nonatomic, copy) UITableViewCell* (^cellCreationBlock)(UITableView* table, NSIndexPath* indexPath);
@property (nonatomic, copy) void (^cellUpdateBlock)(UITableViewCell* cell, id object);

- (id) initWithHeaderTitle: (NSString*) headerTitle
             withDataBlock: (NSArray*(^)()) dataBlock
     withCellCreationBlock: (UITableViewCell*(^)(UITableView* table, NSIndexPath* indexPath)) cellCreationBlock
       withCellUpdateBlock: (void(^)(UITableViewCell* cell, id object)) cellUpdateBlock;

- (void) reloadData;

@end