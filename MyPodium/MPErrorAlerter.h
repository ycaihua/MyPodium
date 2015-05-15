//
//  MPErrorAlerter.h
//  MyPodium
//
//  A custom class that will check an arbitrary
//  number of boolean conditions and present error
//  messages if true. Can use property hasFoundError
//  to take an action if no errors were found. Used
//  for form handling.
//
//  Created by Connor Neville on 5/7/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

@interface MPErrorAlerter : NSObject

@property BOOL hasFoundError;
@property UIViewController* presentingController;

- (id) initFromController: (UIViewController*) controller;

//Displays a UIAlertView with given
//message if (condition == true)
- (void) checkErrorCondition: (BOOL) condition withMessage: (NSString*) message;

@end