//
//  MPErrorAlerter.m
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MPErrorAlerter.h"

@implementation MPErrorAlerter

- (id) initFromController: (UIViewController*) controller {
    self = [super init];
    if(self) {
        self.presentingController = controller;
        self.hasFoundError = false;
    }
    return self;
}

- (void) checkErrorCondition: (BOOL) condition withMessage: (NSString*) message {
    if(condition && !self.hasFoundError) {
        self.hasFoundError = true;
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){}];
        [alert addAction: action];
        [self.presentingController presentViewController:alert animated:TRUE completion:nil];
    }
}

@end