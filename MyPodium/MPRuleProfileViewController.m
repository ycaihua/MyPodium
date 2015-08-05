//
//  MPRuleProfileViewController.m
//  MyPodium
//
//  Created by Connor Neville on 8/5/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPRuleProfileView.h"
#import "MPBottomEdgeButton.h"

#import "MPRuleProfileViewController.h"

@implementation MPRuleProfileViewController

- (id) initWithRule: (PFObject*) rule {
    self = [super init];
    if(self) {
        MPRuleProfileView* view = [[MPRuleProfileView alloc] initWithRule: rule];
        self.view = view;
        self.displayedRule = rule;
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPRuleProfileView* view = (MPRuleProfileView*) self.view;
    [view.bottomButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerManager dismissViewController: self];
}
@end
