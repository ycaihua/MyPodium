//
//  MPEventParticipantsView.h
//  MyPodium
//
//  Created by Connor Neville on 8/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;

@interface MPEventParticipantsView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property UITableView* participantsTable;

@end
