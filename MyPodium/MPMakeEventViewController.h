//
//  MPMakeEventViewController.h
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@class PFObject;

@interface MPMakeEventViewController : MPMenuViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property NSArray* eligibleRules;
@property PFObject* selectedRule;

@end
