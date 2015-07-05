//
//  MPSidebarViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPControllerManager.h"

#import "MPSidebarViewController.h"
#import "MPSidebarView.h"
#import "MPSidebarViewCell.h"
#import "MPSidebarButton.h"

#import "MPHomeViewController.h"
#import "MPRegisterViewController.h"
#import "MPFriendsViewController.h"
#import "MPTeamsViewController.h"
#import "MPMakeTeamViewController.h"
#import "MPSearchViewController.h"
#import "MPAccountDetailsViewController.h"
#import "MPMessagesViewController.h"

#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"

@interface MPSidebarViewController ()

@end

@implementation MPSidebarViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSidebarView* view = [[MPSidebarView alloc] init];
        UITableView* table = view.sidebarTable;
        [table registerClass:[MPSidebarViewCell class]
                  forCellReuseIdentifier:[MPSidebarViewController sidebarReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        self.view = view;
    }
    return self;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPSidebarViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[MPSidebarViewController sidebarReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPSidebarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSidebarViewController sidebarReuseIdentifier]];
    }
    
    //Get destination based on array
    MPMenuViewController* destination = [MPSidebarViewController cellControllerTargets][indexPath.row];
    //Get current container
    MMDrawerController* container = self.mm_drawerController;
    MPMenuViewController* current = (MPMenuViewController*)[container centerViewController];
    if([[current class] isEqual: [destination class]]) {
        [cell.cellButton applyCurrentlyOpenStyle];
    }
    
    [cell.cellButton addTarget:self action:@selector(cellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell updateWithRow: (int)indexPath.row];
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MPSidebarViewCell cellLabelStrings].count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPSidebarViewCell cellHeight];
}

- (void) cellButtonPressed: (id) sender {
    MPSidebarButton* buttonSender = (MPSidebarButton*) sender;
    //Make sure there is an item in array for index
    if(buttonSender.rowIndex >= 0 && buttonSender.rowIndex <
       [MPSidebarViewController cellControllerTargets].count) {
        //Get destination based on array
        Class destinationClass = [MPSidebarViewController cellControllerTargets][buttonSender.rowIndex];
        MPMenuViewController* destination = [[destinationClass alloc] init];
        //Get current container
        MMDrawerController* container = self.mm_drawerController;
        MPMenuViewController* current = (MPMenuViewController*)[container centerViewController];
        //Accessing same controller as already open, just toggle
        if([[destination class] isEqual: [current class]]) {
            [container toggleDrawerSide:MMDrawerSideLeft animated:true completion:nil];
        }
        //Accessing other menuized controller
        else if([destination isKindOfClass: [MPMenuViewController class]]) {
            //MPControllerPresenter handles presenting menu controllers
            [MPControllerManager presentViewController:destination fromController:self];
        }
        //Log out
        else {
            AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
            [delegate logOut];
        }
    }
}

+ (NSString*) sidebarReuseIdentifier { return @"SidebarCell"; }

+ (NSArray*) cellControllerTargets {
    return @[[MPHomeViewController class],
             [MPFriendsViewController class],
             [MPMessagesViewController class],
             [MPMenuViewController class],
             [MPTeamsViewController class],
             [MPMakeTeamViewController class],
             [MPMenuViewController class],
             [MPSearchViewController class],
             [MPAccountDetailsViewController class],
             [MPMenuViewController class],
             [MPMenuViewController class],
             [MPRegisterViewController class]
             ];
}

@end
