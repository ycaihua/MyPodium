//
//  MPHelpViewController.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPLoginView.h"
#import "MPHelpView.h"
#import "MPHelpCell.h"
#import "MPTableHeader.h"
#import "MPLabel.h"

#import "MPHelpViewController.h"

#import <MessageUI/MessageUI.h>

@interface MPHelpViewController ()

@end

@implementation MPHelpViewController

- (id) init {
    self = [super init];
    if(self) {
        MPHelpView* view = [[MPHelpView alloc] init];
        self.view = view;
        [view.bodyTable registerClass:[MPHelpCell class]
      forCellReuseIdentifier:[MPHelpViewController helpReuseIdentifier]];
        [self addControlActions];
    }
    return self;
}

- (void) addControlActions {
    MPHelpView* view = (MPHelpView*) self.view;
    [view.logoButton addTarget:self action:@selector(logoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    for(UIButton* button in view.tableButtons) {
        [button addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    view.bodyTable.delegate = self;
    view.bodyTable.dataSource = self;
}

- (void) logoButtonPressed: (id) sender {
    MPLoginView* presenterView = (MPLoginView*) self.presentingViewController.view;
    [presenterView revertAnimation];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) menuButtonPressed: (id) sender {
    MPHelpView* view = (MPHelpView*) self.view;
    [view selectButton:(UIButton*) sender];
}


- (void) emailButtonPressed: (id) sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"MyPodium Feedback"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@"nevillco@bc.edu"]];
        [mailCont setMessageBody:@"Let me know what you think!" isHTML:NO];
        
        [self presentViewController:mailCont animated:TRUE completion:nil];
    }
}

#pragma mark table delegate/data source

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPHelpCell* cell = [tableView dequeueReusableCellWithIdentifier:
                        [MPHelpViewController helpReuseIdentifier] forIndexPath:indexPath];
    if(!cell) {
        cell = [[MPHelpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MPHelpViewController helpReuseIdentifier]];
    }
    
    MPHelpView* view = (MPHelpView*) self.view;
    [cell.bodyLabel setText:view.bodyStrings[indexPath.section]];
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MPTableHeader headerHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MPHelpView* view = (MPHelpView*) self.view;
    MPTableHeader* header = [[MPTableHeader alloc] initWithText:view.titleStrings[section]];
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

//Calculate height based on UILabel contents
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPHelpView* view = (MPHelpView*) self.view;
    NSString* textForIndex = view.bodyStrings[indexPath.section];
    MPLabel* label = [[MPLabel alloc] initWithText:textForIndex];
    label.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    UITableView* table = view.bodyTable;
    CGSize size = [label sizeThatFits:CGSizeMake(table.frame.size.width, CGFLOAT_MAX)];
    CGFloat buffer = 80.0f;
    return size.height + buffer;
}

+ (NSString*) helpReuseIdentifier { return @"helpIdentifier"; }

//This controller shouldn't support landscape
- (BOOL) shouldAutorotate {
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
