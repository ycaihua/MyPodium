//
//  MPHelpView.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPView.h"
#import "MPLabel.h"

@interface MPHelpView : MPView

@property UIButton* logoButton;
@property MPLabel* returnLabel;

@property UIView* buttonView;

@property UIButton* aboutButton;
@property UIButton* termsButton;
@property UIButton* faqButton;

@property UITableView* bodyTable;
@property UIButton* emailButton;

@property NSArray* bodyStrings;

- (void) selectButton: (UIButton*) button;

@end
