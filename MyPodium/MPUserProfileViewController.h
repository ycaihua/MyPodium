//
//  MPUserProfileViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@class PFUser;

@interface MPUserProfileViewController : MPMenuViewController<MPDataLoader>

@property PFUser* displayedUser;

- (id) initWithUser: (PFUser*) user;

@end
