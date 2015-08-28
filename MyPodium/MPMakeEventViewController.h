//
//  MPMakeEventViewController.h
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"
#import "MPEventTypeView.h"

@class PFObject;

@interface MPMakeEventViewController : MPMenuViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property NSString* eventName;

@property MPEventType selectedEventType;

@property NSArray* eligibleRules;
@property PFObject* selectedRule;

@property NSArray* eligibleParticipants;
@property NSMutableArray* selectedParticipants;

@end
