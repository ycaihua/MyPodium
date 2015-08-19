//
//  MPTeamInviteUsersView.h
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class PFObject;

@interface MPTeamInviteUsersView : MPMenuView

@property PFObject* team;

- (id) initWithTeam: (PFObject*) team;

@end
