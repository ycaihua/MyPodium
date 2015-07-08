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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (read = %@) AND (visibleToReceiver = %@)", user, [NSNumber numberWithBool:false],[NSNumber numberWithBool:true]];
    PFQuery *query = [PFQuery queryWithClassName:@"Message" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    return [query findObjects];
}

+ (NSArray*) readMessagesForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@) AND (read = %@) AND (visibleToReceiver = %@)", user, [NSNumber numberWithBool:true],[NSNumber numberWithBool:true]];
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
    //Want message to remain in sender's "sent" section
    //unless they have hidden it (then actually delete)
    BOOL visibleToSender = [message[@"visibleToSender"] boolValue];
    if(visibleToSender) {
        message[@"visibleToReceiver"] = [NSNumber numberWithBool:NO];
        return [message save];
    }
    else
        return [message delete];
}

+ (BOOL) hideMessageFromSender:(PFObject*) message {
    //Want message to remain in receiver's messages
    //unless they have hidden it (then delete)
    BOOL visibleToReceiver = [message[@"visibleToReceiver"] boolValue];
    if(visibleToReceiver) {
        message[@"visibleToSender"] = [NSNumber numberWithBool:NO];
        return [message save];
    }
    else
        return [message delete];
}

@end
