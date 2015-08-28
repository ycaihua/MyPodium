//
//  MPEventRuleView.h
//  MyPodium
//
//  Created by Connor Neville on 8/24/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPView.h"
#import "MPEventTypeView.h"

@class MPLabel;

@interface MPEventRuleView : MPView

- (id) initWithEventType: (MPEventType) eventType;
- (void) updateForEventType: (MPEventType) eventType;

@property MPLabel* titleLabel;
@property MPLabel* infoLabel;
@property MPLabel* warningLabel;
@property UITableView* rulesTable;
@property UIButton* makeRuleButton;

@end
