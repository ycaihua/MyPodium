//
//  AppDelegate.h
//  MyPodium
//
//  Created by Connor Neville on 5/12/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (MMDrawerController*) makeLoggedInRootController;
- (void) resetRootControllerOnLogOut;

@end

