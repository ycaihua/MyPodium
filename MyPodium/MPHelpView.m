//
//  MPHelpView.m
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHelpView.h"
#import "UIColor+MPColor.h"
#import "MPLabel.h"

@implementation MPHelpView

- (id) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bodyStrings = [MPHelpView generateBodyStrings];
        self.titleStrings = [MPHelpView generateTitleStrings];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.logoButton
    self.logoButton = [[UIButton alloc] init];
    UIImage* image = [UIImage imageNamed:@"about_logo.png"];
    [self.logoButton setImage:image forState:UIControlStateNormal];
    [self.logoButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.logoButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.logoButton];
    
    //self.returnLabel
    self.returnLabel = [[MPLabel alloc] initWithText:@"tap above to return to login"];
    self.returnLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.returnLabel];
    
    //self.buttonView
    self.buttonView = [[UIView alloc] init];
    self.buttonView.backgroundColor = [UIColor MPBlackColor];
    self.buttonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.buttonView];
    
    self.tableButtons = @[[[UIButton alloc] init], [[UIButton alloc] init], [[UIButton alloc] init]];
    for(int i = 0; i < self.tableButtons.count; i++) {
        UIButton* current = self.tableButtons[i];
        [current setTitle:self.titleStrings[i] forState:UIControlStateNormal];
        [current.titleLabel setFont: [UIFont fontWithName:@"Oswald-Bold" size:18.0f]];
        [current setTitleColor:[UIColor MPGrayColor] forState:UIControlStateNormal];
        [current setTitleColor:[UIColor MPYellowColor] forState:UIControlStateHighlighted];
        current.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buttonView addSubview: current];
    }
    
    //self.bodyTable
    self.bodyTable = [[UITableView alloc] init];
    self.bodyTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyTable.scrollEnabled = YES;
    [self addSubview: self.bodyTable];
    
    //self.emailButton
    self.emailButton = [[UIButton alloc] init];
    [self.emailButton setTitle:@"More questions? Email the developer here."
                      forState:UIControlStateNormal];
    [self.emailButton.titleLabel setFont: [UIFont fontWithName:@"Lato-regular" size:14.0f]];
    [self.emailButton setTitleColor:[UIColor MPBlackColor] forState:UIControlStateNormal];
    [self.emailButton setTitleColor:[UIColor MPGreenColor] forState:UIControlStateHighlighted];
    self.emailButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.emailButton];
}

- (void) selectButton: (UIButton*) button {
    for(int i = 0; i < self.tableButtons.count; i++) {
        if([self.tableButtons[i] isEqual: button])
            [self.bodyTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

+ (NSArray*) generateBodyStrings {
    return @[
        (@"MyPodium is your all-in one organizer, scorekeeper and record keeper for any type of recreational competition you and your friends can think of. Once users sign up with just an email address, username and password, they can use the app to create events with a bunch of optional customization choices. MyPodium then takes care of the rest, providing a scoreboard for each match, keeping track of statistics of your choice and displaying charts and information based on those statistics.\n\n"
        "Every MyPodium user has a friends list, which they can use to comprise teams. Events can be leagues, tournaments, or ladders and can pit teams against each other or individual players. Events also need a game mode, which asks the user for information like a time limit or optional statistics to track. Through this system, users can create a truly unique system for their recreational events, and see a wealth of fun statistics about them."),
        (@"-Participant: a competitor in an event. Can be either an individual player or a team of players.\n\n"
        "-Event: a match, tournament, league or ladder.\n\n"
        "-Match: a single competition with one or more winning participants.\n\n"
        "-Tournament: an event where participants are paired in head-to-head matches, eliminating the losers until an overall winner is declared.\n\n"
        "-League: an event where participants are organized into a series of matches. The overall winner is declared based on final record.\n\n"
        "-Ladder: an event where participants can organize their own matches according to their own schedule. Winners gain points according to a formula. The event can be ended by the creator at any time, at which point the winner is the top scorer.\n\n"
        "-Mode: a specification of the event - possibly a sport, card, board or video game. Modes have a number of rounds, an optional time limit per match, and an optional list of statistic names."),
        (@"Do I need an account and internet access?\n\n"
        "Yes: the nature of MyPodium is a very social and statistic-driven one, and for that reason, you'll need an account and internet access to maintain a friends list and all the data you and your friends share.\n\n"
        "How do game mode stats work?\n\n"
        "Game modes are like the topic of your event, and the list of statistics define what the app will track for you. For example, say two different groups of people wanted to host a basketball tournament. They'd both probably title the mode \"Basketball,\" but the first group might make a detailed tournament tracking points, rebounds, assists and steals, while the second might only track points.\n\n"
        "Have you considered adding [suggestion]?\n\n"
        "I am always looking to improve MyPodium. If you find any bugs, or ideas for new features, please feel free to use the button below to email me.")];
}

+ (NSArray*) generateTitleStrings {
    return @[@"ABOUT", @"TERMS", @"FAQ"];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.logoButton
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:4.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.logoButton
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:101.0f],
                           //self.returnLabel
                           [NSLayoutConstraint constraintWithItem:self.returnLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.logoButton
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.returnLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.logoButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.buttonView
                           [NSLayoutConstraint constraintWithItem:self.buttonView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttonView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttonView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.returnLabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:5.0f],
                           [NSLayoutConstraint constraintWithItem:self.buttonView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0f
                                                         constant:40.0f],
                           //self.tableButtons[0]
                           [NSLayoutConstraint constraintWithItem:self.tableButtons[0]
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.tableButtons[0]
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.tableButtons[1]
                           [NSLayoutConstraint constraintWithItem:self.tableButtons[1]
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.tableButtons[1]
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.tableButtons[2]
                           [NSLayoutConstraint constraintWithItem:self.tableButtons[2]
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.tableButtons[2]
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.bodyTable
                           [NSLayoutConstraint constraintWithItem:self.bodyTable
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyTable
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyTable
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.buttonView
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyTable
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.emailButton
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           //self.emailButton
                           [NSLayoutConstraint constraintWithItem:self.emailButton
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailButton
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.emailButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           ]];
}

@end
