//
//  MPFriendsView.m
//  MyPodium
//
//  Created by Connor Neville on 5/17/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPFriendsView.h"
#import <Parse/Parse.h>

@implementation MPFriendsView

- (id) init {
    self = [super initWithTitleText:[PFUser currentUser].username subtitleText:@"friends list"];
    if(self) {
    }
    return self;
}

//Source of frustration! Subclasses of MPMenuView will accidentally
//override makeControls. Best approach is probably using some other name
//(don't want to have to call [super makeControls] again).
- (void) makeFriendsControls {
}
@end
