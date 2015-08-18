//
//  MPTeamRosterViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTeamRosterView.h"

#import "MPTeamRosterViewController.h"

@interface MPTeamRosterViewController ()

@end

@implementation MPTeamRosterViewController

- (id) initWithTeam:(PFObject *)team {
    self = [super init];
    if(self) {
        self.view = [[MPMenuView alloc] initWithTitleText:@"MY PODIUM" subtitleText:@"Loading..."];
        dispatch_async(dispatch_queue_create("UserInfoQueue", 0), ^{
            MPTeamStatus status = [MPTeamsModel teamStatusForUser:[PFUser currentUser] forTeam:team];
            dispatch_async(dispatch_get_main_queue(), ^{
                MPTeamRosterView* view = [[MPTeamRosterView alloc] initWithTeam:team andTeamStatus:status];
                self.view = view;
                self.team = team;
                self.delegate = self;
                [self addMenuActions];
                [self reloadData];
            });
        });
    }
    return self;
}

@end
