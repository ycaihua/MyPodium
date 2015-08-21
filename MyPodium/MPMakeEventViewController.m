//
//  MPMakeEventViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMakeEventView.h"
#import "MPEventNameView.h"
#import "MPFormView.h"
#import "MPTextField.h"

#import "MPMakeEventViewController.h"

@interface MPMakeEventViewController ()

@end

@implementation MPMakeEventViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeEventView* view = [[MPMakeEventView alloc] init];
        self.view = view;
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPMakeEventView* view = (MPMakeEventView*) self.view;
        
    MPEventNameView* nameView = (MPEventNameView*)[view.form slideWithClass:[MPEventNameView class]];
    nameView.nameField.delegate = self;
}

- (BOOL) textFieldShouldReturn:(nonnull UITextField *)textField {
    [textField resignFirstResponder];
    MPMakeEventView* view = (MPMakeEventView*) self.view;
    MPEventNameView* nameView = (MPEventNameView*)[view.form slideWithClass:[MPEventNameView class]];
    MPTextField* nameField = nameView.nameField;
    if([textField isEqual: nameField]) {
        //[self nextButtonPressed: self];
        return YES;
    }
    return YES;
}


@end
