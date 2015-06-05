//
//  MPFriendsModel.m
//  MyPodium
//
//  Created by Connor Neville on 6/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsModel.h"

@implementation MPFriendsModel

+ (BOOL) acceptRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (receiver = %@)",
                              sender, receiver];
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
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

+ (BOOL) removeRequestFromUser: (PFUser*) sender toUser: (PFUser*) receiver {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (receiver = %@)"
                              "AND (accepted = %@)",
                              sender, receiver, [NSNumber numberWithBool:FALSE]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
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
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
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

+ (NSArray*) incomingPendingRequestsForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (accepted = %@)",
                              user, [NSNumber numberWithBool:false]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
    [query includeKey:@"sender"];
    NSArray* matches = [query findObjects];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: matches.count];
    for(PFObject* object in matches) {
        [results addObject:object[@"sender"]];
    }
    return results;
}

+ (NSArray*) outgoingPendingRequestsForUser:(PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (accepted = %@)",
                              user, [NSNumber numberWithBool:false]];
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
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
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
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

+ (NSArray*) friendsForUser: (PFUser*)user containingString: (NSString*) string {
    NSArray* friends = [MPFriendsModel friendsForUser: user];
    NSMutableArray* filteredFriends = [[NSMutableArray alloc] initWithCapacity:friends.count];
    for(PFUser* friend in friends) {
        NSString* username = friend.username;
        NSString* realName = friend[@"realName"];
        if(!realName) realName = @"";
        if([username containsString: string] || [realName containsString: string])
            [filteredFriends addObject: friend];
    }
    return filteredFriends;
}

@end
