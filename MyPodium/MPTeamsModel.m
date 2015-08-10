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

//If you leave a team as the owner, elect new owner
+ (BOOL) leaveTeam: (PFObject*) team forUser: (PFUser*) user {
    NSString* userId = [user objectId];
    NSString* ownerId = [team[@"owner"] objectId];
    if([ownerId isEqualToString: userId]) {
        NSArray* members = team[@"teamMembers"];
        int i = 0;
        //find first member that isn't creator
        while([members[i] isEqualToString: ownerId])
            i++;
        PFQuery* query = [PFUser query];
        [query whereKey:@"objectId" equalTo:members[i]];
        PFUser* userWithId = [query findObjects][0];
        [team setObject:userWithId forKey:@"owner"];
    }
    [team removeObject: userId forKey:@"teamMembers"];
    return [team save];
}

+ (BOOL) makeTeamWithCreator: (PFUser*) user withPlayers: (NSArray*) players withTeamName: (NSString*) teamName {
    PFObject* newTeam = [[PFObject alloc] initWithClassName:[MPTeamsModel tableName]];
    newTeam[@"owner"] = user;
    
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(owner = %@)",
                              user];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    return [query findObjects];
}

+ (NSArray*) teamsContainingUser: (PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN teamMembers)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    return [query findObjects];
}

+ (NSInteger) countTeamsContainingUser: (PFUser*)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN teamMembers)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    return [query countObjects];
}

+ (NSArray*) teamsInvitingUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN invitedMembers)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    return [query findObjects];
}

+ (NSInteger) countTeamsInvitingUser:(PFUser *)user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN invitedMembers)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    return [query countObjects];
}

+ (NSArray*) teamsRequestedByUser: (PFUser*) user {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ IN joinRequests)",
                              user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    return [query findObjects];
}

+ (NSArray*) teamsVisibleToUser: (PFUser*)user {
    NSArray* friendsForUser = [MPFriendsModel friendsForUser:user];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(owner IN %@) AND (owner != %@) AND !(%@ IN teamMembers) AND !(%@ IN invitedMembers) AND !(%@ IN joinRequests)",
                              friendsForUser, user, user.objectId, user.objectId, user.objectId];
    PFQuery *query = [PFQuery queryWithClassName:[MPTeamsModel tableName] predicate:predicate];
    [query includeKey:@"owner"];
    NSArray* results = [query findObjects];
    return results;
}

+ (MPTeamStatus) teamStatusForUser:(PFUser *)user forTeam:(PFObject *)team {
    PFUser* owner = team[@"owner"];
    if([owner.username isEqualToString: user.username]) return MPTeamStatusOwner;
    
    NSArray* members = team[@"teamMembers"];
    if([members containsObject: user.objectId]) return MPTeamStatusMember;
    
    NSArray* invited = team[@"invitedMembers"];
    if([invited containsObject: user.objectId]) return MPTeamStatusInvited;
    
    NSArray* requested = team[@"joinRequests"];
    if([requested containsObject: user.objectId]) return MPTeamStatusRequested;
    
    return MPTeamStatusNonMember;
}

+ (NSString*) tableName { return @"Team"; }
@end
