//
//  MPGlobalModel.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPGlobalModel.h"
#import "MPFriendsModel.h"

@implementation MPGlobalModel

+ (NSArray*) usersContainingString: (NSString*) string {
    if(string.length == 0) return @[];
    PFQuery* query = [PFUser query];
    [query whereKey:@"username" containsString:string];
    return [query findObjects];
}

+ (NSArray*) userSearchContainingString: (NSString*) string forUser: (PFUser*) user {
    NSMutableArray* matches = [MPGlobalModel usersContainingString: string].mutableCopy;
    //Want to exclude the user, and all of user's friends
    NSMutableArray* exclude = [MPFriendsModel friendsForUser:user].mutableCopy;
    //Get usernames of all users to exclude
    NSMutableArray* excludeUsernames = [[NSMutableArray alloc] initWithCapacity:exclude.count + 1];
    for(PFUser* user in exclude) {
        [excludeUsernames addObject:user.username];
    }
    [excludeUsernames addObject: [PFUser currentUser].username];
    //Iterate matches, adding if shouldn't exclude
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity:matches.count];
    for(PFUser* user in matches) {
        if(![excludeUsernames containsObject:user.username])
            [results addObject:user];
    }
    return results;
}

@end
