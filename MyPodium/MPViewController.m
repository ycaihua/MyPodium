//
//  MPViewController.m
//  MyPodium
//
//  Base class for all controllers in MyPodium,
//  containing any behaviors used in
//  all other controller subclasses.
//
//  Created by Connor Neville on 5/13/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPViewController.h"
#import "MPView.h"

@interface MPViewController ()

@end

@implementation MPViewController

- (id) init {
    self = [super init];
    if(self) {
        self.mpView = [[MPView alloc] init];
        self.view = self.mpView;
        [self.mpView.responderButton addTarget:self action:@selector(responderButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//Button event: for all subviews, if they
//are a textfield, resign first responder.
//Should work automatically if both MPView and
//MPViewController are subclassed (?).
- (void)responderButtonPressed:(id)sender {
    for(UIView* subview in self.mpView.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField* currentField = (UITextField*) subview;
            [currentField resignFirstResponder];
        }

    }
}
@end
