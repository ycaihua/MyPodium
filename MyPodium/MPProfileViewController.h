//
//  MPProfileViewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface MPProfileViewController : MPMenuViewController

@property PFUser* user;

- (id) initWithUser: (PFUser*) user;

@end
