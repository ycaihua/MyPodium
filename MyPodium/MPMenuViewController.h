//
//  MPMenuViewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPMenuViewController : UIViewController

- (id) initWithTitle: (NSString*) title subtitle: (NSString*) subtitle;
- (void) addControlActions;

@end
