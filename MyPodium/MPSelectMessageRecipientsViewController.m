//
//  MPSelectMessageRecipientsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 7/8/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPFriendsModel.h"

#import "MPSelectMessageRecipientsView.h"
#import "MPMessageComposerView.h"
#import "MPMenu.h"
#import "MPTextField.h"
#import "MPLabel.h"
#import "MPTableViewCell.h"
#import "MPBottomEdgeButton.h"

#import "MMDrawerController.h"
#import "MPMessageComposerViewController.h"
#import "MPSelectMessageRecipientsViewController.h"

@interface MPSelectMessageRecipientsViewController ()

@end

@implementation MPSelectMessageRecipientsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSelectMessageRecipientsView* view = [[MPSelectMessageRecipientsView alloc] init];
        self.view = view;
        [view startLoading];
        dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
        dispatch_async(backgroundQueue, ^{
            self.friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
            self.selectedFriends = [[NSMutableArray alloc] initWithCapacity: self.friends.count];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Table UI init once data is retrieved
                UITableView* table = view.friendsTable;
                [table registerClass:[MPTableViewCell class]
              forCellReuseIdentifier:[MPSelectMessageRecipientsViewController userReuseIdentifier]];
                table.delegate = self;
                table.dataSource = self;
                [table reloadData];
                
                [view.selectButton addTarget:self action:@selector(selectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view.goBackButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                
                [view finishLoading];
            });
        });
    }
    return self;
}

- (void) selectButtonPressed: (id) sender {
    PFUser* firstFriend = self.selectedFriends[0];
    NSString* recipientsString = firstFriend.username;
    for(int i = 1; i < self.selectedFriends.count; i++) {
        PFUser* nextUser = self.selectedFriends[i];
        recipientsString = [recipientsString stringByAppendingString:
                            [NSString stringWithFormat:@", %@", nextUser.username]];
    }
    MMDrawerController* drawerPresenter = (MMDrawerController*)[self presentingViewController];
    MPMessageComposerViewController* presenter = (MPMessageComposerViewController*) drawerPresenter.centerViewController;
    MPMessageComposerView* presenterView = (MPMessageComposerView*)presenter.view;
    presenterView.recipientsField.text = recipientsString;
    [MPControllerManager dismissViewController:self];
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerManager dismissViewController: self];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPSelectMessageRecipientsViewController userReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSelectMessageRecipientsViewController userReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    [cell setNumberOfButtons:0];
    
    //Update data for appropriate user
    PFUser* user = self.friends[indexPath.row];
    [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withUserObject:user];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (NSIndexPath*) indexPathForUser: (PFUser*) user {
    int row = -1;
    for(int i = 0; i < self.friends.count; i++) {
        PFUser* current = self.friends[i];
        if([current.objectId isEqualToString: user.objectId])
            row = i;
    }
    return [NSIndexPath indexPathForRow:row inSection:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPSelectMessageRecipientsView* view = (MPSelectMessageRecipientsView*) self.view;
    PFUser* friend = self.friends[indexPath.row];
    [self.selectedFriends addObject: friend];
    if(self.selectedFriends.count > 0)
        [view.selectButton enable];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPSelectMessageRecipientsView* view = (MPSelectMessageRecipientsView*) self.view;
    PFUser* friend = self.friends[indexPath.row];
    [self.selectedFriends removeObject: friend];
    if(self.selectedFriends.count == 0)
        [view.selectButton disable];
}

+ (NSString*) userReuseIdentifier { return @"UserIdentifier"; }

@end
