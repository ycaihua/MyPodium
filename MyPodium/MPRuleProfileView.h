//
//  MPRuleProfileView.h
//  MyPodium
//
//  Created by Connor Neville on 8/5/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPLabel;
@class MPBottomEdgeButton;
@class MPProfileControlBlock;

@class PFObject;

@interface MPRuleProfileView : MPMenuView

@property PFObject* displayedRule;

@property MPLabel* nameLabel;
@property MPLabel* participantsLabel;
@property MPLabel* statsLabel;

@property MPBottomEdgeButton* bottomButton;

- (id) initWithRule: (PFObject*) rule;

@end
