//
//  AppDelegate.h
//  MyPodium
//
//  Created by Connor Neville on 5/12/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MPMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (MMDrawerController*) makeLoggedInRootController;
+ (MMDrawerController*) makeLoggedOutRootController;
+ (MMDrawerController*) makeDrawerWithCenterController: (MPMenuViewController*) centerController;
- (void) logOut;

@end

