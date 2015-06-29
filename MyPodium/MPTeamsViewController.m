//
//  MPTeamsViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"
#import "UIButton+MPImage.h"
#import "MPControllerManager.h"
#import "MPTableSectionUtility.h"

#import "MPTeamsModel.h"
#import "MPGlobalModel.h"

#import "MPTeamsView.h"
#import "MPTeamCell.h"
#import "MPTeamsButton.h"
#import "MPTableHeader.h"
#import "MPSearchControl.h"
#import "MPTextField.h"
#import "MPMenu.h"
#import "CNLabel.h"

#import "MPTeamsViewController.h"
#import "MPMakeTeamViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

#import "AppDelegate.h"

@interface MPTeamsViewController ()

@end

@implementation MPTeamsViewController

- (id) init {
    self = [super init];
    if(self) {
        MPTeamsView* view = [[MPTeamsView alloc] init];
        self.view = view;
        //Filter init
        self.isFiltered = NO;
        [view.filterSearch.searchButton addTarget:self
                                           action:@selector(filterSearchButtonPressed:)
                                 forControlEvents:UIControlEventTouchUpInside];
        view.filterSearch.searchField.delegate = self;
        [self makeControlActions];
        [self makeTableSections];
        UITableView* table = view.teamsTable;
        [table registerClass:[MPTeamCell class]
      forCellReuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
        [table registerClass:[UITableViewCell class]
      forCellReuseIdentifier:[MPTeamsViewController blankReuseIdentifier]];
        table.delegate = self;
        table.dataSource = self;
        [view finishLoading];
        [self refreshData];
    }
    return self;
}

- (void) makeTableSections {
    self.tableSections = @[[[MPTableSectionUtility alloc]
                            initWithHeaderTitle:[MPTeamsViewController ownedTeamsHeader]
                            withDataBlock:^(){
                                NSArray* ownedTeams = [MPTeamsModel teamsCreatedByUser:[PFUser currentUser]];
                                if(self.isFiltered) {
                                    MPTeamsView* view = (MPTeamsView*) self.view;
                                    return [MPGlobalModel teamList:ownedTeams searchForString:view.filterSearch.searchField.text];
                                }
                                else return ownedTeams;
                            }
                            withCellCreationBlock:^(UITableView* tableView, NSIndexPath* indexPath){
                                MPTeamCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                                    [MPTeamsViewController teamsReuseIdentifier] forIndexPath:indexPath];
                                if(!cell) {
                                    cell = [[MPTeamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController teamsReuseIdentifier]];
                                }
                                cell.indexPath = indexPath;
                                //Remove any existing actions
                                [cell.leftButton removeTarget:nil
                                                       action:NULL
                                             forControlEvents:UIControlEventAllEvents];
                                [cell.rightButton removeTarget:nil
                                                        action:NULL
                                              forControlEvents:UIControlEventAllEvents];
                                
                                //Set images
                                [cell.leftButton setImageString:@"info" withColorString:@"yellow" withHighlightedColorString:@"black"];
                                [cell.rightButton setImageString:@"x" withColorString:@"red" withHighlightedColorString:@"black"];
                                //Add targets
                                //[cell.leftButton addTarget:self action:@selector(ownedTeamProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                //[cell.rightButton addTarget:self action:@selector(deleteOwnedTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                return cell;
                            }
                            withCellUpdateBlock:^(UITableViewCell* cell, id object){
                                [(MPTeamCell*)cell updateForTeam:object];
                            }],
                           ];
}

- (void) loadOnDismiss: (id) sender {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("ReloadQueue", 0);
    dispatch_async(backgroundQueue, ^{
        MPTeamsView* view = (MPTeamsView*) self.view;
        [self refreshData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.teamsTable reloadData];
        });
    });
}

- (void) refreshData {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.menu.subtitleLabel displayMessage:@"Loading..." revertAfter:NO withColor:[UIColor MPYellowColor]];
    dispatch_queue_t backgroundQueue = dispatch_queue_create("FilterQueue", 0);
    dispatch_async(backgroundQueue, ^{
        for(MPTableSectionUtility* section in self.tableSections) {
            [section reloadData];
            NSLog(@"%@: %lu", section.headerTitle, section.dataObjects.count);
        }
        [self updateHeaders];
        dispatch_async(dispatch_get_main_queue(), ^{
            [view.teamsTable reloadData];
            [view.menu.subtitleLabel displayMessage:[MPTeamsView defaultSubtitle] revertAfter:NO withColor:[UIColor whiteColor]];
        });
    });
}

- (void) updateHeaders {
    NSMutableArray* headerNames = [[NSMutableArray alloc] init];
    for(MPTableSectionUtility* section in self.tableSections) {
        if(section.dataObjects.count > 0) {
            [headerNames addObject: section.headerTitle];
        }
    }
    if(headerNames.count == 0)
        [headerNames addObject: [MPTeamsViewController noneFoundHeader]];
    self.sectionHeaderNames = headerNames;
}

- (void) makeControlActions {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.searchButton addTarget: self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view.makeTeamButton addTarget:self action:@selector(makeTeamButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) searchButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    if(view.searchAvailable) {
        [view hideSearch];
    }
    else {
        [view displaySearch];
    }
}

- (void) makeTeamButtonPressed: (id) sender {
    [MPControllerManager presentViewController:[[MPMakeTeamViewController alloc] init] fromController:self];
}

#pragma mark table view data/delegate

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Blank cell
    if([self.sectionHeaderNames[indexPath.section] isEqualToString:
        [MPTeamsViewController noneFoundHeader]]) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
                                 [MPTeamsViewController blankReuseIdentifier] forIndexPath:indexPath];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPTeamsViewController blankReuseIdentifier]];
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaderNames.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.sectionHeaderNames[section] isEqualToString:[MPTeamsViewController noneFoundHeader]])
        return 1;
    MPTableSectionUtility* sectionUtility = [self tableSectionWithHeader:self.sectionHeaderNames[section]];
    return  sectionUtility.dataObjects.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MPTeamCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[MPTableHeader alloc] initWithText:self.sectionHeaderNames[section]];
}

- (MPTableSectionUtility*) tableSectionWithHeader: (NSString*) header {
    for(MPTableSectionUtility* section in self.tableSections) {
        if([section.headerTitle isEqualToString: header])
            return section;
    }
    return nil;
}

#pragma mark button actions


#pragma mark search filtering

- (void) filterSearchButtonPressed: (id) sender {
    MPTeamsView* view = (MPTeamsView*) self.view;
    [view.filterSearch.searchField resignFirstResponder];
    NSString* filterString = view.filterSearch.searchField.text;
    self.isFiltered = !(filterString.length == 0);
    [self refreshData];
}


#pragma mark textfield delegate

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self textFieldShouldClear: textField];
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    [self filterSearchButtonPressed:nil];
    return YES;
}

#pragma mark constants


+ (NSString*) ownedTeamsHeader { return @"OWNED TEAMS"; }
+ (NSString*) teamsAsMemberHeader { return @"TEAMS I'M ON"; }
+ (NSString*) teamsInvitingHeader { return @"TEAMS INVITING ME"; }
+ (NSString*) teamsRequestedToJoinHeader { return @"TEAMS I REQUESTED TO JOIN"; }
+ (NSString*) noneFoundHeader { return @"NO RESULTS"; }

+ (NSString*) teamsReuseIdentifier { return @"TeamsCell"; }
+ (NSString*) blankReuseIdentifier { return @"BlankCell"; }
@end
