//
//  MPFriendsModel.m
//  MyPodium
//
//  Created by Connor Neville on 6/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsModel.h"

@implementation MPFriendsModel

+ (void) testMethods {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
    if(![PFUser currentUser]) {
        NSLog(@"Log in a user to test MPFriendsModel");
        return;
    }
    dispatch_async(backgroundQueue, ^{
        PFUser* user = [PFUser currentUser];
        NSArray* incomingPendingRequests = [MPFriendsModel incomingPendingRequestsForUser:user];
        NSArray* outgoingPendingRequests = [MPFriendsModel outgoingPendingRequestsForUser:user];
        NSArray* friends = [MPFriendsModel friendsForUser:user];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Incoming requests for logged in user: %lu", (unsigned long)incomingPendingRequests.count);
            NSLog(@"Outgoing requests for logged in user: %lu", (unsigned long)outgoingPendingRequests.count);
            NSLog(@"Friends for logged in user: %lu", (unsigned long)friends.count);
        });
    });
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

@end
