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

+ (BOOL) acceptRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver;
+ (BOOL) removeRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver;
+ (BOOL) removeFriendRelationWithFirstUser: (PFUser*) first secondUser: (PFUser*) second;

+ (NSArray*) incomingPendingRequestsForUser: (PFUser*) user;
+ (NSArray*) outgoingPendingRequestsForUser:(PFUser*)user;
+ (NSArray*) friendsForUser:(PFUser*)user;
+ (NSArray*) friendsForUser:(PFUser*)user containingString: (NSString*) string;

@end
