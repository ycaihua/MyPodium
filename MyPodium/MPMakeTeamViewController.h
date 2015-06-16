//
//  MPMakeTeamViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>

@interface MPMakeTeamViewController : MPMenuViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property NSArray* friends;
@property NSMutableArray* selectedFriends;

@end
