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

+ (BOOL) ruleNameInUse:(NSString *)name forUser:(PFUser *)user {
    NSString* searchName = name.lowercaseString;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@) AND (name_searchable = %@)",
                              user, searchName];
    PFQuery *query = [PFQuery queryWithClassName:[MPRulesModel tableName] predicate:predicate];
    return ([query countObjects] > 0);
}

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

+ (BOOL) makeRuleWithCreator: (PFUser*) user withSettingsDictionary: (NSDictionary*) settings {
    PFObject* newRule = [[PFObject alloc] initWithClassName:[MPRulesModel tableName]];
    newRule[@"creator"] = user;
    
    for(id key in settings) {
        newRule[key] = [settings valueForKey: key];
    }
    
    return [newRule save];
}

+ (BOOL) deleteRule: (PFObject*) rule {
    return [rule delete];
}

+ (NSString*) tableName { return @"Rule"; }
@end