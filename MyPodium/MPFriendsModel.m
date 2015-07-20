//
//  MPFriendsModel.m
//  MyPodium
//
//  Created by Connor Neville on 6/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsModel.h"

@implementation MPFriendsModel

+ (BOOL) sendRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver {
    PFObject* request = [PFObject objectWithClassName:@"Friend"
                                           dictionary:@{@"sender":sender,
                                                        @"receiver":receiver,
                                                        @"accepted":[NSNumber numberWithBool:FALSE]}];
    return [request save];
}

+ (BOOL) acceptRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver canReverse: (BOOL) canReverse {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (receiver = %@)",
                              sender, receiver];
    if(canReverse) predicate = [NSPredicate predicateWithFormat:@"((sender = %@) AND (receiver = %@)) OR ((sender = %@) AND (receiver = %@))", sender, receiver, receiver, sender];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    NSArray* results = [query findObjects];
    if(results.count > 1) {
        NSLog(@"acceptRequestFromUser found multiple results");
        return false;
    }
    else if(results.count == 0) {
        NSLog(@"acceptRequestFromUser found no results");
        return false;
    }
    PFObject* friendObject = results[0];
    friendObject[@"accepted"] = [NSNumber numberWithBool: TRUE];
    return [friendObject save];
}

+ (BOOL) removeRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver canReverse: (BOOL) canReverse {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (receiver = %@)"
                              "AND (accepted = %@)",
                              sender, receiver, [NSNumber numberWithBool:FALSE]];
    if(canReverse) predicate = [NSPredicate predicateWithFormat:@"((sender = %@) AND (receiver = %@)) OR ((sender = %@) AND (receiver = %@)) AND (accepted = %@)", sender, receiver, receiver, sender, [NSNumber numberWithBool:FALSE]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    NSArray* results = [query findObjects];
    if(results.count > 1) {
        NSLog(@"removeRequestFromUser found multiple results");
        return false;
    }
    else if(results.count == 0) {
        NSLog(@"removeRequestFromUser found no results");
        return false;
    }
    PFObject* friendObject = results[0];
    return [friendObject delete];
}

+ (BOOL) removeFriendRelationWithFirstUser:(PFUser *)first secondUser:(PFUser *)second {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(((sender = %@) AND (receiver = %@))"
                              "OR (sender = %@) AND (receiver = %@)) AND (accepted = %@)",
                              first, second, second, first, [NSNumber numberWithBool:TRUE]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    NSArray* results = [query findObjects];
    if(results.count > 1) {
        NSLog(@"removeFriendRelation found multiple results");
        return false;
    }
    else if(results.count == 0) {
        NSLog(@"removeFriendRelation found no results");
        return false;
    }
    PFObject* friendObject = results[0];
    return [friendObject delete];
}

+ (MPFriendStatus) friendStatusFromUser:(PFUser *)firstUser toUser:(PFUser *)secondUser {
    if([firstUser.username isEqualToString: secondUser.username]) return MPFriendStatusSameUser;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((sender = %@) AND (receiver = %@))"
                              "OR ((sender = %@) AND (receiver = %@))",
                              firstUser, secondUser, secondUser, firstUser];
    PFQuery* query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    NSArray* results = [query findObjects];
    
    if(results.count == 0) return MPFriendStatusNotFriends;
    PFObject* friendObject = results[0];
    if(friendObject[@"accepted"] == [NSNumber numberWithBool:TRUE]) return MPFriendStatusFriends;
    PFUser* sender = friendObject[@"sender"];
    if([sender.username isEqualToString: firstUser.username]) return MPFriendStatusOutgoingPending;
    return MPFriendStatusIncomingPending;
}

+ (NSArray*) incomingPendingRequestsForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (accepted = %@)",
                              user, [NSNumber numberWithBool:false]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    [query includeKey:@"sender"];
    NSArray* matches = [query findObjects];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: matches.count];
    for(PFObject* object in matches) {
        [results addObject:object[@"sender"]];
    }
    return results;
}

+ (NSInteger) countIncomingRequestsForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (accepted = %@)",
                              user, [NSNumber numberWithBool:false]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    return [query countObjects];
}

+ (NSArray*) outgoingPendingRequestsForUser:(PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (accepted = %@)",
                              user, [NSNumber numberWithBool:false]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    [query includeKey:@"receiver"];
    NSArray* matches = [query findObjects];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: matches.count];
    for(PFObject* object in matches) {
        [results addObject:object[@"receiver"]];
    }
    return results;
}

+ (NSArray*) friendsForUser: (PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((sender = %@) OR "
                              "(receiver = %@)) AND (accepted = %@)", user, user, [NSNumber numberWithBool:true]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    NSArray* matches = [query findObjects];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: matches.count];
    for(PFObject* object in matches) {
        PFUser* sender = object[@"sender"];
        if([sender.objectId isEqualToString: user.objectId])
            [results addObject: object[@"receiver"]];
        else
            [results addObject: object[@"sender"]];
    }
    return results;
}

+ (NSInteger) countFriendsForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((sender = %@) OR "
                              "(receiver = %@)) AND (accepted = %@)", user, user, [NSNumber numberWithBool:true]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friend" predicate:predicate];
    return [query countObjects];
}

@end
