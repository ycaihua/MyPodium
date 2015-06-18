//
//  MPControllerPresenter.h
//  MyPodium
//
//  Created by Connor Neville on 6/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPControllerPresenter : NSObject

+ (void) presentViewController: (UIViewController*) toPresent fromController: (UIViewController*) presenter;
+ (void) dismissViewController: (UIViewController*) controller;

@end
