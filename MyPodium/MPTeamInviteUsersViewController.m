//
//  MPTeamInviteUsersViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Parse/Parse.h>

#import "MPTeamsModel.h"

#import "MPTeamInviteUsersView.h"

#import "MPTeamInviteUsersViewController.h"

@interface MPTeamInviteUsersViewController ()

@end

@implementation MPTeamInviteUsersViewController

- (id) initWithTeam:(PFObject *)team {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] initWithTitleText:@"MY PODIUM" subtitleText:@"Loading..."];
        dispatch_async(dispatch_queue_create("CountSpotsQueue", 0), ^{
            NSInteger remainingSpots = [MPTeamsModel countRemainingOpeningsOnTeam: team];
            self.team = team;
            self.remainingSpots = remainingSpots;
            dispatch_async(dispatch_get_main_queue(), ^{
                MPTeamInviteUsersView* view = [[MPTeamInviteUsersView alloc] initWithTeam: team withRemainingSpots: remainingSpots];
                self.view = view;
                [self addMenuActions];
            });
        });
    }
    return self;
}

@end
