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
    NSString* searchString = [string lowercaseString];
    PFQuery* query = [PFUser query];
    [query whereKey:@"username_searchable" containsString:searchString];
    return [query findObjects];
}

+ (NSArray*) userSearchContainingString: (NSString*) string forUser: (PFUser*) user {
    NSMutableArray* matches = [MPGlobalModel usersContainingString: string].mutableCopy;
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: matches.count];
    for(PFUser* user in matches) {
        MPFriendStatus status = [MPFriendsModel friendStatusFromUser:[PFUser currentUser] toUser:user];
        if(status == MPFriendStatusNotFriends)
            [results addObject: user];
    }
    return results;
}

+ (NSArray*) userList: (NSArray*) users searchForString: (NSString*) string {
    NSString* searchString = [string lowercaseString];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: users.count];
    for(PFUser* user in users) {
        if(([user[@"username_searchable"] containsString: searchString]) ||
           ([user[@"realName_searchable"] containsString: searchString]))
            [results addObject: user];
    }
    return results;
}

+ (NSArray*) teamList: (NSArray*) teams searchForString: (NSString*) string {
    NSString* searchString = [string lowercaseString];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: teams.count];
    for(PFObject* team in teams) {
        PFUser* creator = team[@"creator"];
        if(([team[@"teamName_searchable"] containsString: searchString]) ||
           ([creator[@"username_searchable"] containsString: searchString]) ||
           ([creator[@"realName_searchable"] containsString: searchString]))
            [results addObject: team];
    }
    return results;
}

+ (NSArray*) messagesList: (NSArray*) messages searchForString: (NSString*) string {
    NSString* searchString = [string lowercaseString];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: messages.count];
    for(PFObject* message in messages) {
        PFUser* sender = message[@"sender"];
        if(([message[@"title_searchable"] containsString: searchString]) ||
           ([message[@"body_searchable"] containsString: searchString]) ||
           ([sender[@"username_searchable"] containsString: searchString]) ||
           ([sender[@"realName_searchable"] containsString: searchString]))
            [results addObject: message];
    }
    return results;
}

@end
