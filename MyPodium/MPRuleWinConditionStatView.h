//
//  MPRuleWinConditionStatView.h
//  MyPodium
//
//  Created by Connor Neville on 7/29/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"

@class MPLabel;

@interface MPRuleWinConditionStatView : MPView

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property UITableView* statTable;

@end
