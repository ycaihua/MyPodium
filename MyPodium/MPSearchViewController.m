//
//  MPSearchViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/4/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPFriendsModel.h"
#import "MPTeamsModel.h"
#import "MPMessagesModel.h"
#import "MPGlobalModel.h"

#import "MPSearchView.h"
#import "MPTableViewCell.h"
#import "MPMessagesCell.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "MPLabel.h"

#import "MPSearchViewController.h"
#import "MPUserProfileViewController.h"
#import "MPMakeTeamViewController.h"
#import "MPMessageReaderViewController.h"
#import "MPTeamRosterViewController.h"

@interface MPSearchViewController ()

@end

@implementation MPSearchViewController

- (id) init {
    self = [super init];
    if(self) {
        MPSearchView* view = [[MPSearchView alloc] init];
        self.view = view;
        self.delegate = self;
        [self makeTableSections];
        [self updateUnfilteredHeaders];
        UITableView* table = view.searchTable;
        [table registerClass:[MPTableViewCell class]
      forCellReuseIdentifier:[MPSearchViewController userReuseIdentifier]];
        [table registerClass:[MPTableViewCell class]
      forCellReuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
        [table registerClass:[MPMessagesCell class]
      forCellReuseIdentifier:[MPSearchViewController messagesReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPSearchViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        //searchView init
        [view.searchView.searchButton addTarget:self
                                           action:@selector(searchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.searchView.searchField.delegate = self;
        [self reloadData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController friendsHeader]
                            withDataBlock:^() {
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userList:[MPFriendsModel friendsForUser:[PFUser currentUser]] searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath) {
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"], @[@"x", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(friendProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(removeFriendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object) {
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withUserObject:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController incomingRequestsHeader]
                            withDataBlock:^(){
                                NSArray* incoming = [MPFriendsModel incomingPendingRequestsForUser: [PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userList:incoming searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:3];
                                [cell clearButtonActions];
                                [cell setButtonImageStrings:@[@[@"check", @"green"], @[@"info", @"yellow"], @[@"x", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[2] addTarget:self action:@selector(acceptIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[1] addTarget:self action:@selector(incomingProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(removeIncomingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withUserObject:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController outgoingRequestsHeader]
                            withDataBlock:^(){
                                NSArray* outgoing = [MPFriendsModel outgoingPendingRequestsForUser: [PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userList:outgoing searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"], @[@"minus", @"red"]]];
                                
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(outgoingProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(removeOutgoingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withUserObject:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController usersHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel userSearchContainingString:view.searchView.searchField.text forUser:[PFUser currentUser]];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController userReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController userReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                [cell setButtonImageStrings:@[@[@"info", @"yellow"], @[@"plus", @"green"]]];
                                
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(sendUserRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [MPTableSectionUtility updateCell:(MPTableViewCell*)cell withUserObject:object];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController ownedTeamsHeader]
                            withDataBlock:^(){
                                NSArray* ownedTeams = [MPTeamsModel teamsCreatedByUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel teamList:ownedTeams searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:3];
                                [cell clearButtonActions];
                                
                                //Set images
                                [cell.buttons[2] setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                [cell.buttons[1] setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.buttons[0] setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.buttons[2] addTarget:self action:@selector(leaveOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[1] addTarget:self action:@selector(ownedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(deleteOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [((MPTableViewCell*)cell).titleLabel setText:object[@"teamName"]];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController teamsAsMemberHeader]
                            withDataBlock:^(){
                                NSArray* memberTeams = [MPTeamsModel teamsContainingUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel teamList:memberTeams searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                
                                //Set images
                                [cell.buttons[1] setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.buttons[0] setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(memberTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(leaveTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [((MPTableViewCell*)cell).titleLabel setText:object[@"teamName"]];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController teamsInvitingHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                NSArray* invites = [MPTeamsModel teamsInvitingUser:[PFUser currentUser]];
                                return [MPGlobalModel teamList:invites searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:3];
                                [cell clearButtonActions];
                                
                                //Set images
                                [cell.buttons[2] setImageString:@"check" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.buttons[1] setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.buttons[0] setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.buttons[2] addTarget:self action:@selector(acceptTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[1] addTarget:self action:@selector(teamInviteProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(denyTeamInviteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [((MPTableViewCell*)cell).titleLabel setText:object[@"teamName"]];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController teamsRequestedToJoinHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                NSArray* joinRequests = [MPTeamsModel teamsRequestedByUser:[PFUser currentUser]];
                                return [MPGlobalModel teamList:joinRequests searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                
                                //Set images
                                [cell.buttons[1] setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.buttons[0] setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(requestedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(cancelTeamRequestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [((MPTableViewCell*)cell).titleLabel setText:object[@"teamName"]];
                            }],
                           
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController visibleTeamsHeader]
                            withDataBlock:^(){
                                MPSearchView* view = (MPSearchView*) self.view;
                                NSArray* visibleTeams = [MPTeamsModel teamsVisibleToUser:[PFUser currentUser]];
                                return [MPGlobalModel teamList:visibleTeams searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPSearchViewController teamReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController teamReuseIdentifier]];
                                }
                                
                                cell.indexPath = indexPath;
                                [cell setNumberOfButtons:2];
                                [cell clearButtonActions];
                                
                                //Set images
                                [cell.buttons[1] setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.buttons[0] setImageString:@"plus" withColorString:@"green" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.buttons[1] addTarget:self action:@selector(visibleTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.buttons[0] addTarget:self action:@selector(requestToJoinTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [((MPTableViewCell*)cell).titleLabel setText:object[@"teamName"]];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController newMessagesHeader]
                            withDataBlock:^(){
                                NSArray* messages = [MPMessagesModel newMessagesForUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel messagesList:messages searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPMessagesCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                        [MPSearchViewController messagesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPMessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController messagesReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell showLeftButton];
                                [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"check" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(readNewMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(markReadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(deleteNewMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object displaySender: YES];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController readMessagesHeader]
                            withDataBlock:^(){
                                NSArray* messages = [MPMessagesModel readMessagesForUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel messagesList:messages searchForString:view.searchView.searchField.text];
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPMessagesCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                        [MPSearchViewController messagesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPMessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController messagesReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell showLeftButton];
                                [cell.leftButton setImageString:@"info" withColorString:@"green" withHighlightedColorString:@"black"];
                                [cell.centerButton setImageString:@"up" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.leftButton addTarget:self action:@selector(rereadMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.centerButton addTarget:self action:@selector(markUnreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(deleteReadMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object displaySender: YES];
                            }],
                           
                           [[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPSearchViewController sentMessagesHeader]
                            withDataBlock:^(){
                                NSArray* messages = [MPMessagesModel sentMessagesForUser:[PFUser currentUser]];
                                MPSearchView* view = (MPSearchView*) self.view;
                                return [MPGlobalModel messagesList:messages searchForString:view.searchView.searchField.text];
                                
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPMessagesCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                        [MPSearchViewController messagesReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPMessagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController messagesReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.centerButton removeTarget:nil
                                                         action:NULL
                                               forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell hideLeftButton];
                                [cell.centerButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"minus" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                [cell.centerButton addTarget:self action:@selector(readSentMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [cell.rightButton addTarget:self action:@selector(hideSentMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPMessagesCell*)cell updateForMessage:object displaySender:NO];
                            }]
                           ];
}

- (void) refreshDataForController:(MPMenuViewController *)controller {
    MPSearchViewController* searchVC = (MPSearchViewController*)controller;
    for(MPTableSectionUtility* sectionUtility in searchVC.tableSections) {
        [sectionUtility reloadData];
    }
    [searchVC updateUnfilteredHeaders];
}

- (UITableView*) tableViewToRefreshForController:(MPMenuViewController *)controller {
    MPSearchViewController* searchVC = (MPSearchViewController*)controller;
    MPSearchView* view = (MPSearchView*)searchVC.view;
    return view.searchTable;
}

#pragma mark table view data/delegate
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPSearchViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                [MPSearchViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPSearchViewController blankReuseIdentifier]];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    }
    else {
        NSString* sectionHeader = self.sectionHeaderNames[indexPath.section];
        MPTableSectionUtility* section = [self tableSectionWithHeader: sectionHeader];
        UITableViewCell* cell = section.cellCreationBlock(tableView, indexPath);
        id object = section.dataObjects[indexPath.row];
        section.cellUpdateBlock(cell, object);
        return cell;
    }
}

- (void) friendProfileButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController friendsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeFriendButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController friendsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeFriendRelationWithFirstUser:other secondUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You successfully removed %@ as a friend.", other.username]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to remove %@ as a friend?", other.username]
      shouldShowConfirmation:showConfirmation];
}

- (void) acceptIncomingButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController incomingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel acceptRequestFromUser:other toUser:[PFUser currentUser] canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You accepted %@'s friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."];
}

- (void) incomingProfileButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController incomingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeIncomingButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController incomingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeRequestFromUser:other toUser:[PFUser currentUser] canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You denied %@'s friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to deny the friend request from %@?", other.username]
      shouldShowConfirmation:showConfirmation];
}

- (void) outgoingProfileButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController outgoingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) removeOutgoingButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController outgoingRequestsHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel removeRequestFromUser:[PFUser currentUser] toUser:other canReverse:YES];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your friend request to %@.", other.username]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Are you sure you want to cancel your friend request to %@?", other.username]
      shouldShowConfirmation:showConfirmation];
}

- (void) userProfileButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController usersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPUserProfileViewController alloc] initWithUser:other] fromController:self];
}

- (void) sendUserRequestButtonPressed: (id) sender {
    MPTableViewCell* cell = (MPTableViewCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController usersHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPFriendsModel sendRequestFromUser:[PFUser currentUser] toUser:other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You sent %@ a friend request.", other.username]
            withErrorMessage:@"There was an error processing the request."];
}

- (void) ownedTeamProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) leaveOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You left your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to leave your team, %@? A new owner will be chosen.", other[@"teamName"]]
      shouldShowConfirmation:showConfirmation];
}

- (void) deleteOwnedTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController ownedTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel deleteTeam: other];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to delete your team, %@? This cannot be undone.", other[@"teamName"]]
      shouldShowConfirmation:showConfirmation];
}

- (void) memberTeamProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsAsMemberHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) leaveTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsAsMemberHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel leaveTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You deleted your team, %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to leave your team, %@? If you are the owner, a new owner will be assigned.", other[@"teamName"]]
      shouldShowConfirmation:showConfirmation];
}

- (void) acceptTeamInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsInvitingHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel acceptInviteFromTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You joined the team %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."];
}

- (void) teamInviteProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsInvitingHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) denyTeamInviteButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsInvitingHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyInviteFromTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You denied the team invite from %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to deny the invitation from %@?", other[@"teamName"]]
      shouldShowConfirmation:showConfirmation];
}

- (void) requestedTeamProfileButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsRequestedToJoinHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPTeamRosterViewController alloc] initWithTeam:other] fromController:self];
}

- (void) cancelTeamRequestButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController teamsRequestedToJoinHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel denyJoinRequestForTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You cancelled your join request for %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:[NSString stringWithFormat:@"Do you want to cancel your join request for the team %@?", other[@"teamName"]]
      shouldShowConfirmation:showConfirmation];
}

- (void) visibleTeamProfileButtonPressed: (id) sender {
    //Need to create team profile
}

- (void) requestToJoinTeamButtonPressed: (id) sender {
    UIButton* buttonSender = (UIButton*) sender;
    MPTableViewCell* cell = (MPTableViewCell*)buttonSender.superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController visibleTeamsHeader]];
    PFObject* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPTeamsModel requestToJoinTeam:other forUser:[PFUser currentUser]];
    }
          withSuccessMessage:[NSString stringWithFormat:@"You requested to join %@.", other[@"teamName"]]
            withErrorMessage:@"There was an error processing the request."];
}

- (void) readNewMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController newMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPMessageReaderViewController alloc] initWithMessage:other] fromController:self];
}

- (void) markReadButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController newMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel markMessageRead: other];
    }
          withSuccessMessage:@"You marked the message as read."
            withErrorMessage:@"There was an error processing the request."];
}

- (void) deleteNewMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController newMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel deleteMessage: other];
    }
          withSuccessMessage:@"You deleted the message."
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:@"Are you sure you want to permanently delete this message?"
      shouldShowConfirmation:showConfirmation];
}

- (void) rereadMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController readMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPMessageReaderViewController alloc] initWithMessage:other] fromController:self];
}

- (void) markUnreadButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController readMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel markMessageUnread: other];
    }
          withSuccessMessage:@"You marked the message as unread."
            withErrorMessage:@"There was an error processing the request."];
}

- (void) deleteReadMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController readMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    BOOL showConfirmation = [[PFUser currentUser][@"pref_confirmation"] boolValue];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel deleteMessage: other];
    }
          withSuccessMessage:@"You deleted the message."
            withErrorMessage:@"There was an error processing the request."
     withConfirmationMessage:@"Are you sure you want to permanently delete this message?"
      shouldShowConfirmation:showConfirmation];
}

- (void) readSentMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController sentMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [MPControllerManager presentViewController:[[MPMessageReaderViewController alloc] initWithMessage:other] fromController:self];
}

- (void) hideSentMessageButtonPressed: (id) sender {
    MPMessagesCell* cell = (MPMessagesCell*)((UIButton*)sender).superview;
    NSIndexPath* indexPath = cell.indexPath;
    MPTableSectionUtility* utility = [self tableSectionWithHeader:[MPSearchViewController sentMessagesHeader]];
    PFUser* other = utility.dataObjects[indexPath.row];
    [self performModelUpdate:^BOOL{
        return [MPMessagesModel hideMessageFromSender: other];
    }
          withSuccessMessage:@"You removed the message from your sent box."
            withErrorMessage:@"There was an error processing the request."];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:[MPSearchViewController noneFoundHeader]])
        return 1;
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.sectionHeaderNames[section]];
    return  sectionUtility.dataObjects.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:self.sectionHeaderNames[section]];
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
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPSearchViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

#pragma mark button actions

- (void) searchButtonPressed: (id) sender {
    MPSearchView* view = (MPSearchView*) self.view;
    [self filterDataWithString:view.searchView.searchField.text];
}

- (void) filterDataWithString: (NSString*) string {
    if(string.length == 0)
        return;
    
    MPSearchView* view = (MPSearchView*) self.view;
    [view.searchView.searchField resignFirstResponder];
    [self reloadData];
}

- (MPTableSectionUtility*) tableSectionWithHeader: (NSString*) header {
    for(MPTableSectionUtility* section in self.tableSections) {
        if([section.headerTitle isEqualToString: header])
            return section;
    }
    return nil;
}

#pragma mark class methods

+ (NSString*) friendsHeader { return @"FRIENDS"; }
+ (NSString*) incomingRequestsHeader { return @"INCOMING FRIEND REQUESTS"; }
+ (NSString*) outgoingRequestsHeader { return @"OUTGOING FRIEND REQUESTS"; }
+ (NSString*) usersHeader { return @"OTHER USERS"; }
+ (NSString*) ownedTeamsHeader { return @"OWNED TEAMS"; }
+ (NSString*) teamsAsMemberHeader { return @"TEAMS I'M ON"; }
+ (NSString*) teamsInvitingHeader { return @"TEAMS INVITING ME"; }
+ (NSString*) teamsRequestedToJoinHeader { return @"TEAMS I REQUESTED TO JOIN"; }
+ (NSString*) visibleTeamsHeader { return @"OTHER VISIBLE TEAMS"; }
+ (NSString*) newMessagesHeader { return @"NEW MESSAGES"; }
+ (NSString*) readMessagesHeader { return @"READ MESSAGES"; }
+ (NSString*) sentMessagesHeader { return @"SENT MESSAGES"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) userReuseIdentifier { return @"userSearchIdentifier"; }
+ (NSString*) teamReuseIdentifier { return @"teamSearchIdentifier"; }
+ (NSString*) messagesReuseIdentifier { return @"messagesReuseIdentifier"; }
+ (NSString*) blankReuseIdentifier { return @"blankIdentifier"; }

@end
