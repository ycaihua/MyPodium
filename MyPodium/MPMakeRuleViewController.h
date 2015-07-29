//
//  MPMakeRuleViewController.h
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuViewController.h"

@interface MPMakeRuleViewController : MPMenuViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property NSArray* statNameData;

@end
