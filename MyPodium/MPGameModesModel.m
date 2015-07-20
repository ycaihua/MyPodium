//
//  MPGameModesModel.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPGameModesModel.h"

#import <Parse/Parse.h>

@implementation MPGameModesModel

+ (NSArray*) gameModesForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPGameModesModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSInteger) countGameModesForUser:(PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPGameModesModel tableName] predicate:predicate];
    return [query countObjects];
}

+ (NSString*) tableName { return @"GameMode"; }
@end