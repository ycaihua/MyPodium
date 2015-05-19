//
//  MPProfileView.m
//  MyPodium
//
//  Created by Connor Neville on 5/18/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPProfileView.h"

@implementation MPProfileView

- (id) init {
    self = [super initWithTitleText:@"USERNAME" subtitleText:@"profile"];
    if(self) {
    }
    return self;
}

//Source of frustration! Subclasses of MPMenuView will accidentally
//override makeControls. Best approach is probably using some other name
//(don't want to have to call [super makeControls] again).
- (void) makeProfileControls {
}
@end
