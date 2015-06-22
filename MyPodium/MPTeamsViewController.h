//
//  MPTeamsViewController.h
//  MyPodium
//
//  Created by Connor Neville on 6/9/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

#import <UIKit/UIKit.h>

@interface MPTeamsViewController : MPMenuViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property NSArray* invitesList;
@property NSArray* teamsOwnedList;
@property NSArray* allTeamsList;
@property BOOL isFiltered;
@property NSMutableArray* invitesFilteredList;
@property NSMutableArray* teamsOwnedFilteredList;
@property NSMutableArray* allTeamsFilteredList;

@property NSMutableArray* sectionHeaderNames;

+ (NSString*) invitesHeader;
+ (NSString*) teamsOwnedHeader;
+ (NSString*) allTeamsHeader;

@end