//
//  MPRuleProfileViewController.h
//  MyPodium
//
//  Created by Connor Neville on 8/5/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@class PFObject;

@interface MPRuleProfileViewController : MPMenuViewController

@property PFObject* displayedRule;

- (id) initWithRule: (PFObject*) rule;

@end
