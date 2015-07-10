//
//  MPTeamsModel.m
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPTeamsModel.h"
#import "MPFriendsModel.h"

@implementation MPTeamsModel

+ (BOOL) acceptInviteFromTeam:(PFObject *)team forUser:(PFUser *)user {
    [team removeObject:user.objectId forKey:@"invitedMembers"];
    [team addObject:user.objectId forKey:@"teamMembers"];
    return [team save];
}

+ (BOOL) denyInviteFromTeam:(PFObject *)team forUser:(PFUser *)user {
    [team removeObject:user.objectId forKey:@"invitedMembers"];
    return [team save];
}

+ (BOOL) deleteTeam:(PFObject *)team {
    return [team delete];
}

+ (BOOL) requestToJoinTeam:(PFObject *)team forUser:(PFUser *)user {
    [team addObject:user.objectId forKey:@"joinRequests"];
    return [team save];
}

+ (BOOL) acceptTeamJoinRequest:(PFObject *)team forUser:(PFUser *)user {
    [team removeObject:user.objectId forKey:@"joinRequests"];
    [team addObject:user.objectId forKey:@"teamMembers"];
    return [team save];
}

+ (BOOL) denyTeamJoinRequest:(PFObject *)team forUser:(PFUser *)user {
    [team removeObject:user.objectId forKey:@"joinRequests"];
    return [team save];
}

//If you leave a team as the owner, elect new creator
+ (BOOL) leaveTeam: (PFObject*) team forUser: (PFUser*) user {
    NSString* userId = [user objectId];
    NSString* creatorId = [team[@"creator"] objectId];
    if([creatorId isEqualToString: userId]) {
        NSArray* members = team[@"teamMembers"];
        int i = 0;
        //find first member that isn't creator
        while([members[i] isEqualToString: creatorId])
            i++;
        PFQuery* query = [PFUser query];
        [query whereKey:@"objectId" equalTo:members[i]];
        PFUser* userWithId = [query findObjects][0];
        [team setObject:userWithId forKey:@"creator"];
    }
    [team removeObject: userId forKey:@"teamMembers"];
    return [team save];
}

+ (BOOL) makeTeamWithCreator: (PFUser*) user withPlayers: (NSArray*) players withTeamName: (NSString*) teamName {
    PFObject* newTeam = [[PFObject alloc] initWithClassName:[MPTeamsModel tableName]];
    newTeam[@"creator"] = user;
    
    newTeam[@"teamMembers"] = @[];
    newTeam[@"invitedMembers"] = @[];
    newTeam[@"joinRequests"] = @[];
    [newTeam addObject:[user objectId] forKey:@"teamMembers"];
    for(PFUser* member in players) {
        [newTeam addObject:[member objectId] forKey:@"invitedMembers"];
    }

    newTeam[@"teamName"] = teamName;
    newTeam[@"teamName_searchable"] = [teamName lowercaseString];
    return [newTeam save];
}

+ (NSArray*) teamsCreatedByUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSArray*) teamsContainingUser: (PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN teamMembers)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSArray*) teamsInvitingUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN invitedMembers)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSArray*) teamsRequestedByUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN joinRequests)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSArray*) teamsVisibleToUser: (PFUser*)user {
    NSArray* friendsForUser = [MPFriendsModel friendsForUser:user];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(creator IN %@) AND (creator != %@) AND !(%@ IN teamMembers) AND !(%@ IN invitedMembers) AND !(%@ IN joinRequests)",
                              friendsForUser, user, user.objectId, user.objectId, user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"creator"];
    NSArray* results = [query findObjects];
    return results;
}

+ (NSString*) tableName { return @"Team"; }
@end
