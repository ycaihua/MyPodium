//
//  MPRulesModel.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPRulesModel.h"

#import <Parse/Parse.h>

@implementation MPRulesModel

+ (NSArray*) rulesForUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPRulesModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSInteger) countRulesForUser:(PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPRulesModel tableName] predicate:predicate];
    return [query countObjects];
}

+ (NSString*) tableName { return @"Rule"; }
@end