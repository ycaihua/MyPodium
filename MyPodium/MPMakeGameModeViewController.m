//
//  MPMakeGameModeViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/20/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPMakeGameModeViewController.h"
#import "MPMakeGameModeView.h"
#import "MPBottomEdgeButton.h"

@interface MPMakeGameModeViewController ()

@end

@implementation MPMakeGameModeViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeGameModeView* view = [[MPMakeGameModeView alloc] init];
        self.view = view;
        [self makeControlActions];
    }
    return self;
}

- (void) makeControlActions {
    MPMakeGameModeView* view = (MPMakeGameModeView*) self.view;
    [view.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) nextButtonPressed: (id) sender {
    MPMakeGameModeView* view = (MPMakeGameModeView*) self.view;
    BOOL (^block)() = [MPMakeGameModeViewController errorCheckingBlocks][0];
    BOOL noErrorsFound = block();
    if(noErrorsFound) {
        [view advanceToNextSubview];
        [view.previousButton setTitle:@"PREVIOUS" forState:UIControlStateNormal];
        if(view.subviewIndex == view.modeSubviews.count - 1) {
            [view.nextButton disable];
        }
        else {
            [view.nextButton enable];
        }
    }
}

- (void) previousButtonPressed: (id) sender {
    MPMakeGameModeView* view = (MPMakeGameModeView*) self.view;
    if(view.subviewIndex == 0) {
        [MPControllerManager dismissViewController:self];
    }
    else {
        [view returnToLastSubview];
        if(view.subviewIndex == 0) {
            [view.previousButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        }
        else {
            [view.previousButton setTitle:@"PREVIOUS" forState:UIControlStateNormal];
        }
    }
}

+ (NSArray*) errorCheckingBlocks {
    return @[^() { return NO; }
             
             ];
}

@end
