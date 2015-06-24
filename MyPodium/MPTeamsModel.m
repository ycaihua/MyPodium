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

+ (BOOL) acceptInviteFromTeam: (PFObject*) team forUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (receiver = %@)",
                              team, user];
    PFQuery *query = [PFQuery queryWithClassName:@"TeamInvites" predicate:predicate];
    [query includeKey:@"sender"];
    NSArray* results = [query findObjects];
    if(results.count > 1) {
        NSLog(@"acceptInviteFromTeam found multiple results");
        return false;
    }
    else if(results.count == 0) {
        NSLog(@"acceptInviteFromTeam found no results");
        return false;
    }
    PFObject* teamInvite = results[0];
    PFObject* senderTeam = teamInvite[@"sender"];
    [senderTeam addObject: user.username forKey:@"teamMembers"];
    return ([senderTeam save] && [teamInvite delete]);
}

+ (BOOL) denyInviteFromTeam: (PFObject*) team forUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@) AND (receiver = %@)",
                              team, user];
    PFQuery *query = [PFQuery queryWithClassName:@"TeamInvites" predicate:predicate];
    [query includeKey:@"sender"];
    NSArray* results = [query findObjects];
    if(results.count > 1) {
        NSLog(@"denyInviteFromTeam found multiple results");
        return false;
    }
    else if(results.count == 0) {
        NSLog(@"denyInviteFromTeam found no results");
        return false;
    }
    PFObject* teamInvite = results[0];
    return [teamInvite delete];
}

//To delete a team, should also delete all pending invites from team
+ (BOOL) deleteTeam:(PFObject *)team {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@)",
                              team];
    PFQuery *query = [PFQuery queryWithClassName:@"TeamInvites" predicate:predicate];
    NSArray* invites = [query findObjects];
    return ([PFObject deleteAll:invites] && [team delete]);
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
    PFObject* newTeam = [[PFObject alloc] initWithClassName:@"Team"];
    newTeam[@"creator"] = user;
    
    newTeam[@"teamMembers"] = @[];
    [newTeam addObject:[user objectId] forKey:@"teamMembers"];
    for(PFUser* member in players) {
        [newTeam addObject:[member objectId] forKey:@"teamMembers"];
    }
    
    newTeam[@"teamName"] = teamName;
    return [newTeam save];
}

+ (NSArray*) teamsCreatedByUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:@"Team" predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSArray*) teamsContainingUser: (PFUser*)user {
    NSString* userID = user.objectId;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN teamMembers)",
                              userID];
    PFQuery *query = [PFQuery queryWithClassName:@"Team" predicate:predicate];
    [query includeKey:@"creator"];
    return [query findObjects];
}

+ (NSArray*) teamsInvitingUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(receiver = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:@"TeamInvites" predicate:predicate];
    [query includeKey:@"sender"];
    [query includeKey:@"receiver"];
    NSArray* matches = [query findObjects];
    NSMutableArray* results = [[NSMutableArray alloc] initWithCapacity: matches.count];
    for(PFObject* object in matches) {
        PFObject* team = object[@"sender"];
        [results addObject:team];
    }
    return results;
}

+ (NSArray*) teamsVisibleToUser: (PFUser*)user {
    NSArray* friendsForUser = [MPFriendsModel friendsForUser:user];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creator IN %@) OR (creator = %@)",
                              friendsForUser, user];
    PFQuery *query = [PFQuery queryWithClassName:@"Team" predicate:predicate];
    [query includeKey:@"creator"];
    NSArray* results = [query findObjects];
    return results;
}
@end
