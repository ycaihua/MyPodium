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
#import "MPControllerPresenter.h"

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"

#import "MPMakeTeamView.h"
#import "MPTeamsView.h"
#import "MPTextField.h"
#import "MPUserCell.h"
#import "MPMenu.h"
#import "CNLabel.h"
#import "MPTeamsButton.h"

#import "MPMakeTeamViewController.h"
#import "MPTeamsViewController.h"
#import "MPLoginViewController.h"

@interface MPMakeTeamViewController ()

@end

@implementation MPMakeTeamViewController

- (id) init {
    self = [super init];
    if(self) {
        MPMakeTeamView* view = [[MPMakeTeamView alloc] init];
        self.view = view;
        [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
        dispatch_queue_t backgroundQueue = dispatch_queue_create("FriendsQueue", 0);
        dispatch_async(backgroundQueue, ^{
            self.friends = [MPFriendsModel friendsForUser:[PFUser currentUser]];
            self.selectedFriends = [[NSMutableArray alloc] initWithCapacity: self.friends.count];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Table UI init once data is retrieved
                UITableView* table = view.playersTable;
                [table registerClass:[MPUserCell class]
              forCellReuseIdentifier:[MPMakeTeamViewController makeTeamReuseIdentifier]];
                table.delegate = self;
                table.dataSource = self;
                [table reloadData];
                [view.menu.subtitleLabel displayMessage:[MPMakeTeamView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
                
                [view.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [view.goBackButton addTarget:self action:@selector(goBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                view.teamNameField.delegate = self;
            });
        });
    }
    return self;
}

#pragma mark table view delegate/data source

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPUserCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPMakeTeamViewController makeTeamReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPMakeTeamViewController makeTeamReuseIdentifier]];
    }
    
    cell.indexPath = indexPath;
    
    //don't need buttons unless selected
    [cell.rightButton setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"green"];
    [cell.leftButton removeFromSuperview];
    [cell.rightButton removeFromSuperview];
    
    //Update data for appropriate user
    PFUser* user = self.friends[indexPath.row];
    [cell updateForUser: user];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPUserCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMakeTeamView* view = (MPMakeTeamView*) self.view;
    PFUser* friend = self.friends[indexPath.row];
    [self.selectedFriends addObject: friend];
    if(self.selectedFriends.count == 1)
        [view enableSubmitButton];
    [view.teamNameField resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMakeTeamView* view = (MPMakeTeamView*) self.view;
    PFUser* friend = self.friends[indexPath.row];
    [self.selectedFriends removeObject: friend];
    if(self.selectedFriends.count == 0)
        [view disableSubmitButton];
    [view.teamNameField resignFirstResponder];
}

#pragma mark button events

- (void) submitButtonPressed: (id) sender {
    MPErrorAlerter* alerter = [[MPErrorAlerter alloc] initFromController:self];
    MPMakeTeamView* view = (MPMakeTeamView*) self.view;
    [alerter checkErrorCondition:(view.teamNameField.text.length < 2) withMessage:@"Your team name must be at least 3 characters long."];
    [alerter checkErrorCondition:(view.teamNameField.text.length > 16) withMessage:@"Your team name can't be more than 16 characters long."];
    [alerter checkErrorCondition:(self.selectedFriends.count < 1) withMessage:@"You need to select at least one teammate."];
    [alerter checkErrorCondition:(self.selectedFriends.count > 11) withMessage:@"You can have at most 12 players on your team (counting yourself)."];
    if(![alerter hasFoundError]) {
        dispatch_queue_t backgroundQueue = dispatch_queue_create("MakeTeamQueue", 0);
        dispatch_async(backgroundQueue, ^{
            BOOL success = [MPTeamsModel makeTeamWithCreator:[PFUser currentUser] withPlayers:self.selectedFriends withTeamName:view.teamNameField.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(success) {
                    UIAlertController* successAlert =
                    [UIAlertController alertControllerWithTitle:@"Success"
                                                        message:[NSString stringWithFormat:@"You've created a new team named %@. You'll now be returned to the home page.", view.teamNameField.text]
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
                        [MPLoginViewController login];
                    }];
                    [successAlert addAction:action];
                    [self presentViewController:successAlert animated:true completion:nil];
                }
                else {
                    UIAlertController* errorAlert =
                    [UIAlertController alertControllerWithTitle:@"Error"
                                                        message:@"There was an error creating the team. Please try again later."
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction* handler){
                    }];
                    [errorAlert addAction:action];
                    [self presentViewController:errorAlert animated:true completion:nil];
                }
            });
        });
    }
}

- (void) goBackButtonPressed: (id) sender {
    [MPControllerPresenter dismissViewController: self];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

+ (NSString*) makeTeamReuseIdentifier { return @"MakeTeamIdentifier"; }

@end
