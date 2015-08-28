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

+ (BOOL) eventNameInUse:(NSString *)name forUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(owner = %@) AND (name = %@)",
                              user, name];
    PFQuery *query = [PFQuery queryWithClassName:[MPEventsModel tableName] predicate:predicate];
    return ([query countObjects] > 0);
}

+ (BOOL) createEventWithName:(NSString *)name withOwner:(PFObject *)user withType:(MPEventType)type withRule:(PFObject *)rule withParticipants:(NSArray *)participants {
    PFObject* newEvent = [[PFObject alloc] initWithClassName:[MPEventsModel tableName]];
    newEvent[@"name"] = name;
    newEvent[@"name_searchable"] = name.lowercaseString;
    newEvent[@"owner"] = user;
    switch (type) {
        case MPEventTypeMatch:
            newEvent[@"eventType"] = @"Match";
            break;
        case MPEventTypeLadder:
            newEvent[@"eventType"] = @"Ladder";
            break;
        case MPEventTypeLeague:
            newEvent[@"eventType"] = @"League";
            break;
        case MPEventTypeTournament:
            newEvent[@"eventType"] = @"Tournament";
            break;
        default:
            break;
    }
    newEvent[@"rule"] = rule;
    newEvent[@"participantIDs"] = @[];
    newEvent[@"invitedParticipantIDs"] = @[];
    for(PFUser* participant in participants) {
        [newEvent addObject:participant.objectId forKey:@"invitedParticipantIDs"];
    }
    newEvent[@"testDict"] = @{@"test1": @"test2"};
    return [newEvent save];
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
