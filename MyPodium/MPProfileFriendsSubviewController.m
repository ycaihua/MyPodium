//
//  MPProfileFriendsSubviewController.m
//  MyPodium
//
//  Created by Connor Neville on 5/21/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileFriendsSubviewController.h"

@interface MPProfileFriendsSubviewController ()

@end

@implementation MPProfileFriendsSubviewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (id) initWithUser: (PFUser*) user {
    self = [super init];
    if(self) {
        self.user = user;
    }
    return self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    /*
    NSLog(@"Here1");
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(sender = %@ OR receiver = %@) AND accepted = %@",
                              self.user, self.user, TRUE];
    PFQuery *query = [PFQuery queryWithClassName:@"Friends" predicate:predicate];
    NSLog(@"Here2");
    self.friendsList = [query findObjects];
    NSLog(@"Here3");
    int count = self.friendsList.count;
    NSLog(@"%d", count);
    return count;
     */
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MPProfileFriendsSubviewIdentifier" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MPProfileFriendsSubviewIdentifier"];
    }
    */
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
