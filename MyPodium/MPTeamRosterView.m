//
//  MPTeamProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 8/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTeamRosterView.h"
#import "MPLabel.h"

#import <Parse/Parse.h>

@implementation MPTeamRosterView

- (id) initWithTeam: (PFObject*) team andTeamStatus: (MPTeamStatus) status {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[MPTeamRosterView defaultSubtitle]];
    if(self) {
        self.team = team;
        self.teamStatus = status;
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.titleLabel
    self.titleLabel = [[MPLabel alloc] initWithText:[self.team[@"teamName"] uppercaseString]];
    //self.statusLabel
    self.statusLabel = [[MPLabel alloc] init];
    switch (self.teamStatus) {
        case MPTeamStatusOwner:
            self.statusLabel.text = @"You are the owner of this team.";
            break;
        case MPTeamStatusMember:
            self.statusLabel.text = @"You are a member of this team.";
            break;
        case MPTeamStatusInvited:
            self.statusLabel.text = @"You have been invited to join this team.";
            break;
        case MPTeamStatusRequested:
            self.statusLabel.text = @"You have requested to join this team.";
            break;
        case MPTeamStatusNonMember:
            self.statusLabel.text = @"You are not a member of this team.";
        default:
            break;
    }
}

- (void) makeControlConstraints {
    
}

+ (NSString*) defaultSubtitle { return @"Team Roster"; }

@end
