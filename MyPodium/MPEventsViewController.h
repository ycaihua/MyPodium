//
//  MPEventsViewController.h
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>

@interface MPEventsViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MPDataLoader>

@property NSArray* tableSections;

@property BOOL isFiltered;

@property NSMutableArray* sectionHeaderNames;

@end