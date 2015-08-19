//
//  MPTeamInviteUsersView.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTeamInviteUsersView.h"

#import <Parse/Parse.h>

@implementation MPTeamInviteUsersView

- (id) initWithTeam:(PFObject *)team {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPTeamInviteUsersView defaultSubtitle]];
    if(self) {
        self.team = team;
    }
    return self;
}

+ (NSString*) defaultSubtitle { return @"Invite Users"; }

@end
