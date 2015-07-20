//
//  MPGameModesViewController.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>

@interface MPGameModesViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property NSArray* tableSections;

@property BOOL isFiltered;

@property NSMutableArray* sectionHeaderNames;

@end