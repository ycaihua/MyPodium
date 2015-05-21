//
//  MPProfileFriendsSubviewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/21/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MPProfileFriendsSubviewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

- (id) initWithUser: (PFUser*) user;

@property PFUser* user;
@property NSArray* friendsList;

@end
