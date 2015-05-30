//
//  MPSidebarButton.h
//  MyPodium
//
//  Created by Connor Neville on 5/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPDualLabelButton.h"

@interface MPSidebarButton : MPDualLabelButton

@property int rowIndex;

- (void) cellButtonPressed: (id) sender;

@end
