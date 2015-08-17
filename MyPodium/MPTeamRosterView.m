//
//  MPTeamProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 8/10/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPTeamRosterView.h"

#import <Parse/Parse.h>

@implementation MPTeamRosterView

- (id) initWithTeam: (PFObject*) team {
    self = [super initWithTitleText:@"MY PODIUM" subtitleText:[NSString stringWithFormat:@"Team Roster: %@", team[@"name"]]];
    if(self) {
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.statusLabel
}

- (void) makeControlConstraints {
    
}

+ (NSString*) defaultSubtitle { return @"Team Roster"; }

@end
