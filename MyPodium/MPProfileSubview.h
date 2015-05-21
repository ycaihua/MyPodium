//
//  MPProfileSubviewFriends.h
//  MyPodium
//
//  Created by Connor Neville on 5/19/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNLabel.h"
#import "MPProfileSubviewButton.h"

@interface MPProfileSubview : UIView

@property UIView* sideBorder;
@property UIView* grayBorder;
@property MPProfileSubviewButton* sidebarButton;
@property UITableView* contentTable;

@end
