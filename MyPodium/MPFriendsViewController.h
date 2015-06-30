//
//  MPFriendsViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@interface MPFriendsViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property NSArray* tableSections;
@property BOOL isFiltered;

@property NSMutableArray* sectionHeaderNames;

@end
