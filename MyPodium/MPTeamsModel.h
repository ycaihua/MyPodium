//
//  MPTeamsModel.h
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface MPTeamsModel : NSObject

+ (BOOL) acceptInviteFromTeam: (PFObject*) team forUser: (PFUser*) user;
+ (BOOL) denyInviteFromTeam: (PFObject*) team forUser: (PFUser*) user;
+ (BOOL) requestToJoinTeam: (PFObject*) team forUser: (PFUser*) user;
+ (BOOL) acceptTeamJoinRequest: (PFObject*) team forUser: (PFUser*) user;
+ (BOOL) denyTeamJoinRequest: (PFObject*) team forUser: (PFUser*) user;
+ (BOOL) deleteTeam: (PFObject*) team;
+ (BOOL) leaveTeam: (PFObject*) team forUser: (PFUser*) user;
+ (BOOL) makeTeamWithCreator: (PFUser*) user withPlayers: (NSArray*) players withTeamName: (NSString*) teamName;

+ (NSInteger) countTeamsInvitingUser: (PFUser*) user;
+ (NSInteger) countTeamsContainingUser: (PFUser*) user;

+ (NSArray*) teamsCreatedByUser: (PFUser*) user;
+ (NSArray*) teamsContainingUser: (PFUser*) user;
+ (NSArray*) teamsInvitingUser: (PFUser*) user;
+ (NSArray*) teamsRequestedByUser: (PFUser*) user;
+ (NSArray*) teamsVisibleToUser: (PFUser*) user;

@end
