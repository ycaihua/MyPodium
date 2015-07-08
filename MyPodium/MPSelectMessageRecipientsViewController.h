//
//  MPSelectMessageRecipientsViewController.h
//  MyPodium
//
//  Created by Connor Neville on 7/8/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@interface MPSelectMessageRecipientsViewController : MPMenuViewController<UITableViewDataSource, UITableViewDelegate>

@property NSArray* friends;
@property NSMutableArray* selectedFriends;

@end
