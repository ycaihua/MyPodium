//
//  MPUserSearchViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPUserSearchViewController.h"
#import "MPUserSearchView.h"
#import "MPFriendsModel.h"
#import "MPGlobalModel.h"

@interface MPUserSearchViewController ()

@end

@implementation MPUserSearchViewController

- (id) init {
    self = [super init];
    if(self) {
        MPUserSearchView* view = [[MPUserSearchView alloc] init];
        self.view = view;
        //searchView init
        [view.searchView.searchButton addTarget:self
                                           action:@selector(searchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.searchView.searchField.delegate = self;
    }
    return self;
}

#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    [self searchButtonPressed: nil];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchButtonPressed: nil];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self textFieldShouldClear: textField];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self searchButtonPressed:nil];
    return YES;
}

#pragma mark table headers

- (void) updateUnfilteredHeaders {
    self.sectionHeaderNames = [[NSMutableArray alloc] initWithCapacity:3];
    if(self.matchingFriends.count == 0 && self.matchingUsers.count == 0) {
        [self.sectionHeaderNames addObject:[MPUserSearchViewController noneFoundHeader]];
        return;
    }
    if(self.matchingFriends.count > 0)
        [self.sectionHeaderNames addObject:[MPUserSearchViewController friendsHeader]];
    if(self.matchingUsers.count > 0)
        [self.sectionHeaderNames addObject:[MPUserSearchViewController usersHeader]];
}

#pragma mark button actions

- (void) searchButtonPressed: (id) sender {
    MPUserSearchView* view = (MPUserSearchView*) self.view;
    [self filterDataWithString:view.searchView.searchField.text];
}

- (void) filterDataWithString: (NSString*) string {
    if(string.length == 0) {
        self.matchingFriends = @[];
        self.matchingUsers = @[];
        return;
    }
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
    dispatch_async(backgroundQueue, ^{
        self.matchingFriends = [MPFriendsModel friendsForUser:[PFUser currentUser] containingString:string];
        self.matchingUsers = [MPGlobalModel usersContainingString:string];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUnfilteredHeaders];
            MPUserSearchView* view = (MPUserSearchView*) self.view;
            [view.searchTable reloadData];
        });
    });
}

#pragma mark class methods

+ (NSString*) friendsHeader { return @"FRIENDS"; }
+ (NSString*) usersHeader { return @"OTHER USERS"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

@end
