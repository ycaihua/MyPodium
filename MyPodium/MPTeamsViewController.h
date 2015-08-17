//
//  MPTeamsViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>

@interface MPTeamsViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MPDataLoader>

@property NSArray* tableSections;

@property BOOL isFiltered;

@property NSMutableArray* sectionHeaderNames;

@end