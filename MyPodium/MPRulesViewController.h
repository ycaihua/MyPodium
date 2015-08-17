//
//  MPRulesViewController.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>

@interface MPRulesViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MPDataLoader>

@property NSArray* tableSections;

@property BOOL isFiltered;

@property NSMutableArray* sectionHeaderNames;

@end