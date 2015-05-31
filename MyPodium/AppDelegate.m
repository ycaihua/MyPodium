//
//  AppDelegate.m
//  MyPodium
//
//  Created by Connor Neville on 5/12/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "AppDelegate.h"
#import "MPLoginViewController.h"
#import "MPSidebarViewController.h"
#import "MPHomeViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:path];
    // Initialize Parse
    [Parse setApplicationId:[plist objectForKey:@"ParseAppId"]
                  clientKey:[plist objectForKey:@"ParseClientKey"]];
    
    //Display status bar in landscape
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    // [Optional] Track statistics around application opens
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if([PFUser currentUser]) {
        //Uncomment to force log out:
        //[PFUser logOut];
        //[self.window setRootViewController:[[MPLoginViewController alloc] init]];
        [self.window setRootViewController:[AppDelegate makeLoggedInRootController]];
    }
    else {
        //[self.window setRootViewController:[AppDelegate makeLoggedOutRootController]];
        [self.window setRootViewController:[AppDelegate makeLoggedInRootController]];
    }
    [self.window makeKeyAndVisible];
    return YES;
}

+ (MPLoginViewController*) makeLoggedOutRootController {
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    return [[MPLoginViewController alloc] init];
}

+ (MMDrawerController*) makeLoggedInRootController {
    return [AppDelegate makeDrawerWithCenterController:[[MPHomeViewController alloc] init]];
}

+ (MMDrawerController*) makeDrawerWithCenterController: (MPMenuViewController*) centerController {
    //Will need to be the menu
    MPSidebarViewController *left = [[MPSidebarViewController alloc] init];
    
    MMDrawerController* drawer = [[MMDrawerController alloc] initWithCenterViewController:centerController leftDrawerViewController:left];
    
    //Actions have to be added to MPMenuViewController after it has
    //a drawer container (above)
    [centerController addMenuActions];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    
    drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureModeCustom;
    drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    //Custom gesture to close sidebar on any touch of center
    [drawer setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        BOOL shouldRecognizeTouch = NO;
        if(drawerController.openSide == MMDrawerSideLeft &&
           ([gesture isKindOfClass:[UITapGestureRecognizer class]] ||
            [gesture isKindOfClass:[UIPanGestureRecognizer class]])){
               UIView * customView = [drawerController.centerViewController view];
               CGPoint location = [touch locationInView:customView];
               shouldRecognizeTouch = (CGRectContainsPoint(customView.bounds, location));
           }
        return shouldRecognizeTouch;
    }];
    
    return drawer;
    
}

- (void) logOut {
    if([PFUser currentUser]) [PFUser logOut];
    [self.window setRootViewController:[AppDelegate makeLoggedOutRootController]];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
