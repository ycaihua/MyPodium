//
//  MPEventsModel.m
//  MyPodium
//
//  Created by Connor Neville on 8/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>

#import "MPEventsModel.h"

@implementation MPEventsModel

+ (NSInteger) countEventsForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(owner = %@) OR (%@ IN participantIDs)",
                              user, user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPEventsModel tableName] predicate:predicate];
    return [query countObjects];
}

+ (NSArray*) eventsOwnedByUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(owner = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPEventsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    return [query findObjects];
}

+ (NSString*) tableName { return @"Event"; }

@end
