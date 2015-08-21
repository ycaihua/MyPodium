//
//  MPEventTypeView.m
//  MyPodium
//
//  Created by Connor Neville on 8/21/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPEventTypeView.h"

@implementation MPEventTypeView

- (id) init {
    self = [super init];
    if(self) {
        self.selectedIndex = 0;
        self.allImages = @[[UIImage imageNamed:@"match_150.png"],
                           [UIImage imageNamed:@"tournament_150.png"],
                           [UIImage imageNamed:@"league_150.png"],
                           [UIImage imageNamed:@"ladder_150.png"]];
        self.allTitles = @[@"MATCH",
                           @"TOURNAMENT",
                           @"LEAGUE",
                           @"LADDER"];
        self.allDescriptions = @[@"Play a quick single match without the commitment of the other event types. You can still see your stats after.",
                                 @"Create a single or double elimination tournament. We'll setup a bracket for you.",
                                 @"Play in a league format that schedules a series of matches against the different participants.",
                                 @"After each match in a ladder, the winner climbs up the ladder while the loser drops down. Play as many matches as you want in this event."];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    //self.currentImageView
    self.currentImageView = [[UIImageView alloc] initWithImage:self.allImages[self.selectedIndex]];
    self.currentImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.currentImageView];
    
    //self.currentTitle
    self.currentTitle = [[MPLabel alloc] initWithText:self.allTitles[self.selectedIndex]];
    self.currentTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentTitle.font = [UIFont fontWithName:@"Oswald-Bold" size:24.0f];
    [self addSubview: self.currentTitle];
}

- (void) makeControlConstraints {
    
}

@end
