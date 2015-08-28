//
//  MPMakeEventRuleHandler.h
//  MyPodium
//
//  Created by Connor Neville on 8/28/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPMakeEventRuleHandler : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (id) initWithEventType: (MPEventType) type;

@property NSArray* eligibleRules;
@property PFObject* selectedRule;

@end
