//
//  MPMenuViewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPMenuViewController : UIViewController

@property BOOL menuActionsAdded;

//This method is made public because, if the controller's
//drawer isn't connected, it isn't called on init
- (void) addMenuActions;

@end
