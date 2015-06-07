//
//  MPHelpView.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"
@class MPLabel;

@interface MPHelpView : MPView

@property UIButton* logoButton;
@property MPLabel* returnLabel;

@property UIView* buttonView;
@property NSArray* tableButtons;

@property UITableView* bodyTable;
@property UIButton* emailButton;

@property NSArray* bodyStrings;
@property NSArray* titleStrings;

- (void) selectButton: (UIButton*) button;

@end
