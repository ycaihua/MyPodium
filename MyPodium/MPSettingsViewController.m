//
//  MPSettingsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/1/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPErrorAlerter.h"
#import "MPLimitConstants.h"
#import "UIColor+MPColor.h"

#import "MPSettingsView.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPSettingsViewController.h"

#import <Parse/Parse.h>

@interface MPSettingsViewController ()

@end

@implementation MPSettingsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSettingsView* view = [[MPSettingsView alloc] init];
        [view.submitNameButton addTarget:self action:@selector(submitNameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.view = view;
    }
    return self;
}

- (void) submitNameButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController: self];
    NSString* name = ((MPSettingsView*)self.view).realNameField.text;
    [alerter checkErrorCondition:(name.length < [MPLimitConstants minRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names need to be at least %d characters.", [MPLimitConstants minRealNameCharacters]]];
    [alerter checkErrorCondition:(name.length > [MPLimitConstants maxRealNameCharacters]) withMessage:[NSString stringWithFormat:@"Real names can be at most %d characters.", [MPLimitConstants maxRealNameCharacters]]];
    if(![alerter hasFoundError]) {
        dispatch_queue_t saveNameThread = dispatch_queue_create("SaveName", 0);
        dispatch_async(saveNameThread, ^{
            ((MPSettingsView*)self.view).realNameField.text = @"";
            PFUser* currentUser = [PFUser currentUser];
            currentUser[@"realName"] = name;
            BOOL success = [currentUser save];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alerter checkErrorCondition:(!success) withMessage:@"There was a problem saving your name. Please try again later."];
                if(![alerter hasFoundError]) {
                    [((MPSettingsView*)self.view).menu.subtitleLabel displayMessage:@"Your name was saved." revertAfter:true withColor:[UIColor MPGreenColor]];
                }
            });
        });
    }
    
}

@end
