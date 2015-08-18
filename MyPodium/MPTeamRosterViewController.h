//
//  MPTeamRosterViewController.h
//  MyPodium
//
//  Created by Connor Neville on 8/18/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@class PFObject;

@interface MPTeamRosterViewController : MPMenuViewController<UITableViewDataSource, UITableViewDelegate, MPDataLoader>

@property PFObject* team;
@property MPTeamStatus status;

@property NSArray* tableSections;
@property NSMutableArray* tableHeaders;

- (id) initWithTeam: (PFObject*) team;

@end
