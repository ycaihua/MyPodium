//
//  MPTeamInviteUsersViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>

#import "MPTeamInviteUsersView.h"

#import "MPTeamInviteUsersViewController.h"

@interface MPTeamInviteUsersViewController ()

@end

@implementation MPTeamInviteUsersViewController

- (id) initWithTeam:(PFObject *)team {
    self = [super init];
    if(self) {
        MPTeamInviteUsersView* view = [[MPTeamInviteUsersView alloc] initWithTeam: team];
        self.view = view;
        self.team = team;
    }
    return self;
}

@end
