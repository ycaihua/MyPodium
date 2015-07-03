//
//  MPMessagesModel.m
//  MyPodium
//
//  Created by Connor Neville on 7/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMessagesModel.h"
#import <Parse/Parse.h>

@implementation MPMessagesModel

+ (NSArray*) newMessagesForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (read = %@)",
                              user, [NSNumber numberWithBool:false]];
    PFQuery *query = [PFQuery queryWithClassName:@"Message" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    return [query findObjects];
}

+ (NSArray*) readMessagesForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (read = %@)",
                              user, [NSNumber numberWithBool:true]];
    PFQuery *query = [PFQuery queryWithClassName:@"Message" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    return [query findObjects];
}

+ (NSArray*) sentMessagesForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (visibleToSender = %@)",
                              user, [NSNumber numberWithBool:true]];
    PFQuery *query = [PFQuery queryWithClassName:@"Message" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    return [query findObjects];
}

+ (BOOL) markMessageRead:(PFObject*) message {
    message[@"read"] = [NSNumber numberWithBool:true];
    return [message save];
}

+ (BOOL) markMessageUnread:(PFObject*) message {
    message[@"read"] = [NSNumber numberWithBool:false];
    return [message save];
}

+ (BOOL) deleteMessage:(PFObject*) message {
    return [message delete];
}

+ (BOOL) hideMessageFromSender:(PFObject*) message {
    message[@"visibleToSender"] = [NSNumber numberWithBool:false];
    return [message save];
}

@end
