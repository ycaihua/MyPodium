//
//  MPMakeTeamViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>
@class PFUser;

@interface MPMakeTeamViewController : MPMenuViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MPDataLoader>

- (id) initWithSelectedUser: (PFUser*) user;

@property NSArray* friends;
@property NSMutableArray* selectedFriends;

@end
