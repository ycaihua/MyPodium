//
//  MPMatchesModel.m
//  MyPodium
//
//  Created by Connor Neville on 8/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>

#import "MPMatchesModel.h"
#import "MPEventsModel.h"

#import "MPEventTypeView.h"

@implementation MPMatchesModel

+ (BOOL) createMatchesForEvent:(PFObject *)event {
    MPEventType type = [MPEventsModel typeOfEvent: event];
    if(type == MPEventTypeMatch) {
        PFObject* match = [[PFObject alloc] initWithClassName:[MPMatchesModel tableName]];
        PFObject* rule = event[@"rule"];
        match[@"parent"] = event;
        match[@"rule"] = rule;
        NSMutableDictionary* playerStats = @{}.mutableCopy;
        for(NSString* playerStat in rule[@"playerStats"]) {
            [playerStats setObject:@{} forKey:playerStat];
        }
        match[@"playerStats"] = playerStats;
        NSMutableDictionary* teamStats = @{}.mutableCopy;
        for(NSString* teamStat in rule[@"teamStats"]) {
            [teamStats setObject:@{} forKey:teamStat];
        }
        match[@"teamStats"] = teamStats;
        BOOL success = [match save];
        if(success) {
            event[@"matches"] = @[match.objectId];
            return [event save];
        }
        return NO;
            
    }
    else if(type == MPEventTypeLadder) {
        event[@"matches"] = @[];
        return [event save];
    }
    return YES;
}

+ (NSString*) tableName { return @"Match"; }

@end
