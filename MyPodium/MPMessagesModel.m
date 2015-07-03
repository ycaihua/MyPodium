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
    return [query findObjects];
}

@end
