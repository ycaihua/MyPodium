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
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
}

- (void) makeControls {
    self.allImages = @[[UIImage imageNamed:@"match_150.png"],
                       [UIImage imageNamed:@"tournament_150.png"],
                       [UIImage imageNamed:@"league_150.png"],
                       [UIImage imageNamed:@"ladder_150.png"]
                       ];
}

- (void) makeControlConstraints {
    
}

@end
