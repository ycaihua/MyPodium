//
//  MPSidebarViewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPSidebarViewController.h"
#import "MPSidebarView.h"
#import "MPSidebarViewCell.h"
#import "MPHomeViewController.h"
#import "MPRegisterViewController.h"
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

- (void) cellButtonPressed: (id) sender {
    MPSidebarButton* buttonSender = (MPSidebarButton*) sender;
    //Make sure there is an item in array for index
    if(buttonSender.rowIndex >= 0 && buttonSender.rowIndex < [MPSidebarViewController cellControllerTargets].count) {
        MMDrawerController* container = self.mm_drawerController;
        UIViewController* destination = [MPSidebarViewController cellControllerTargets][buttonSender.rowIndex];
        if([destination isKindOfClass: [MPMenuViewController class]]) {
            //We want to keep drawer structure in tact
            MPMenuViewController* destWithMenu = (MPMenuViewController*) destination;
            [container setCenterViewController:destWithMenu withCloseAnimation:true completion:nil];
            [destWithMenu addMenuActions];
        }
        else {
            AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
            [delegate logOut];
            //Log out user, reset root controller
        }
    }
}

+ (NSString*) sidebarReuseIdentifier { return @"SidebarCell"; }

+ (NSArray*) cellControllerTargets {
    return @[[[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPHomeViewController alloc] init],
             [[MPRegisterViewController alloc] init]
             ];
}

@end
