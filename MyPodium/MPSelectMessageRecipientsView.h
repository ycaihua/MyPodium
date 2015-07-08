//
//  MPSelectMessageRecipientsView.h
//  MyPodium
//
//  Created by Connor Neville on 7/8/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;
@class MPBottomEdgeButton;

@interface MPSelectMessageRecipientsView : MPMenuView

@property MPLabel* instructionLabel;
@property UITableView* friendsTable;
@property MPBottomEdgeButton* goBackButton;
@property MPBottomEdgeButton* selectButton;

+ (NSString*) defaultSubtitle;

@end
