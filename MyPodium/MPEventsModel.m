//
//  MPEventsModel.m
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>

#import "MPTeamsModel.h"
#import "MPEventsModel.h"

@implementation MPEventsModel

+ (BOOL) deleteEvent:(PFObject *)event {
    return [event delete];
}

+ (NSInteger) countEventsForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(owner = %@) OR (%@ IN userIDs)",
                              user, user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPEventsModel tableName] predicate:predicate];
    return [query countObjects];
}

+ (NSArray*) eventsOwnedByUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(owner = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPEventsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    [query includeKey:@"rule"];
    return [query findObjects];
}

+ (NSArray*) eventsWithParticipatingUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN userIDs)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPEventsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    [query includeKey:@"rule"];
    return [query findObjects];
}

+ (NSArray*) eventsInvitingUser:(PFUser *)user {
    return nil;
}

+ (NSString*) tableName { return @"Event"; }

@end
