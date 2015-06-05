//
//  MPFriendsCell.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"
#import "MPUserCell.h"
#import <Parse/Parse.h>

@interface MPFriendsCell : MPUserCell

- (void) updateForIncomingRequest;
- (void) updateForFriendOrOutgoingRequest;

@end
