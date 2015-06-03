//
//  MPFriendsModel.h
//  MyPodium
//
//  Created by Connor Neville on 6/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface MPFriendsModel : NSObject

+ (void) testMethods;

+ (BOOL) acceptRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver;
+ (BOOL) denyRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver;

+ (NSArray*) incomingPendingRequestsForUser: (PFUser*) user;
+ (NSArray*) outgoingPendingRequestsForUser:(PFUser*)user;
+ (NSArray*) friendsForUser:(PFUser*)user;

@end
