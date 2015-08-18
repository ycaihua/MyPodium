//
//  MPMakeTeamViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/15/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIButton+MPImage.h"
#import "UIColor+MPColor.h"
#import "MPErrorAlerter.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"
#import "MPLimitConstants.h"

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"

#import "MPMakeTeamView.h"
#import "MPTeamsView.h"
#import "MPTextField.h"
#import "MPTableViewCell.h"
#import "MPMenu.h"
#import "MPLabel.h"
#import "MPBottomEdgeButton.h"

#import "MPMakeTeamViewController.h"
#import "MPTeamsViewController.h"
#import "MPLoginViewController.h"

@interface MPMakeTeamViewController ()

@end

@implementation MPMakeTeamViewController

- (id) initWithSelectedUser:(PFUser *)user {
    self = [super init];
    if(self) {
        MPMakeTeamView* view = [[MPMakeTeamView alloc] init];
        self.view = view;
        [view startLoading];
        dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
        dispatch_async(backgroundQueue, ^{
            self.friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
            self.selectedFriends = [[NSMutableArray alloc] initWithCapacity: self.friends.count];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Table UI init once data is retrieved
                UITableView* table = view.playersTable;
                [table registerClass:[MPTableViewCell class]
              forCellReuseIdentifier:[MPMakeTeamViewController makeTeamReuseIdentifier]];
                table.delegate = self;
                table.dataSource = self;
                [table reloadData];
                
                if(user) {
                    NSIndexPath* path = [self indexPathForUser: user];
                    [self.selectedFriends addObject: self.friends[path.row]];
                    [view.submitButton enable];
                    [view.playersTable selectRowAtIndexPath:path animated:true scrollPosition:UITableViewScrollPositionMiddle];
                }
                [view finishLoading];
                
                [view.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view.goBackButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                view.teamNameField.delegate = self;
            });
        });
    }
    return self;
}

- (id) init {
    return [self initWithSelectedUser: nil];
}

#pragma mark MPDataLoader

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPMakeTeamViewController* makeTeamVC = (MPMakeTeamViewController*)controller;
    makeTeamVC.friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPMakeTeamViewController* makeTeamVC = (MPMakeTeamViewController*)controller;
    MPMakeTeamView* view = (MPMakeTeamView*)makeTeamVC.view;
    return view.playersTable;
}

#pragma mark table view delegate/data source

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPMakeTeamViewController makeTeamReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeTeamViewController makeTeamReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    [cell setNumberOfButtons: 0];
    
    //Update data for appropriate user
    PFUser* user = self.friends[indexPath.row];
    [MPTableSectionUtility updateCell:cell withUserObject: user];
    
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
    MPMakeTeamView* view = (MPMakeTeamView*) self.view;
    PFUser* friend = self.friends[indexPath.row];
    [self.selectedFriends addObject: friend];
    if(self.selectedFriends.count > 0)
        [view.submitButton enable];
    [view.teamNameField resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMakeTeamView* view = (MPMakeTeamView*) self.view;
    PFUser* friend = self.friends[indexPath.row];
    [self.selectedFriends removeObject: friend];
    if(self.selectedFriends.count == 0)
        [view.submitButton disable];
    [view.teamNameField resignFirstResponder];
}

#pragma mark button events

- (void) submitButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    MPMakeTeamView* view = (MPMakeTeamView*) self.view;
    [alerter checkErrorCondition:(view.teamNameField.text.length < [MPLimitConstants minTeamNameCharacters])
                     withMessage:[NSString stringWithFormat: @"Your team name must be at least %d characters long.", [MPLimitConstants minTeamNameCharacters]]];
    [alerter checkErrorCondition:(view.teamNameField.text.length > [MPLimitConstants maxTeamNameCharacters])
                     withMessage:[NSString stringWithFormat: @"Your team name cannot be longer than %d characters.", [MPLimitConstants maxTeamNameCharacters]]];
    [alerter checkErrorCondition:(self.selectedFriends.count < 1) withMessage:@"You need to select at least one teammate."];
    [alerter checkErrorCondition:(self.selectedFriends.count > [MPLimitConstants maxPlayersPerTeam] - 1)
                     withMessage:[NSString stringWithFormat:@"You can have at most %d players on your team (counting yourself).", [MPLimitConstants maxPlayersPerTeam]]];
    if(![alerter hasFoundError]) {
        dispatch_queue_t backgroundQueue = dispatch_queue_create("MakeTeamQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL success = [MPTeamsModel makeTeamWithCreator:[PFUser currentUser] withPlayers:self.selectedFriends withTeamName:view.teamNameField.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success) {
                    UIAlertController* successAlert =
                    [UIAlertController alertControllerWithTitle:@"Success"
                                                        message:[NSString stringWithFormat:@"You've created a new team named %@. You'll now be returned to the previous screen.", view.teamNameField.text]
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
                        [MPControllerManager dismissViewController: self];
                    }];
                    [successAlert addAction:action];
                    [self presentViewController:successAlert animated:true completion:nil];
                }
                else {
                    UIAlertController* errorAlert =
                    [UIAlertController alertControllerWithTitle:@"Error"
                                                        message:@"There was an error creating the team. Please try again later."
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
                    [errorAlert addAction:action];
                    [self presentViewController:errorAlert animated:true completion:nil];
                }
            });
        });
    }
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerManager dismissViewController: self];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

+ (NSString*) makeTeamReuseIdentifier { return @"MakeTeamIdentifier"; }

@end
