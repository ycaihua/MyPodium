//
//  MPDataLoader.h
//  MyPodium
//
//  Created by Connor Neville on 8/17/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPMenuViewController;

@protocol MPDataLoader <NSObject>

- (void) refreshDataForController: (MPMenuViewController*) controller;
- (UITableView*) tableViewToRefreshForController: (MPMenuViewController*) controller;

@end
