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

typedef NS_ENUM(NSInteger, MPFriendStatus) {
    MPFriendStatusSameUser,
    MPFriendStatusFriends,
    MPFriendStatusNotFriends,
    MPFriendStatusIncomingPending,
    MPFriendStatusOutgoingPending
};

+ (BOOL) sendRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver;
+ (BOOL) acceptRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver canReverse: (BOOL) canReverse;
+ (BOOL) removeRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver;
+ (BOOL) removeFriendRelationWithFirstUser: (PFUser*) first secondUser: (PFUser*) second;

+ (MPFriendStatus) friendStatusFromUser: (PFUser*) sender toUser: (PFUser*) toUser;

+ (NSArray*) incomingPendingRequestsForUser: (PFUser*) user;
+ (NSArray*) outgoingPendingRequestsForUser:(PFUser*)user;
+ (NSArray*) friendsForUser:(PFUser*)user;
+ (NSArray*) friendsForUser:(PFUser*)user containingString: (NSString*) string;

@end
