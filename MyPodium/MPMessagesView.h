//
//  MPMessagesView.h
//  MyPodium
//
//  Created by Connor Neville on 6/2/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPSearchControl;
@class MPTableHeader;

@interface MPMessagesView : MPMenuView

@property MPSearchControl* filterSearch;
@property MPTableHeader* loadingHeader;
@property UITableView* messagesTable;

+ (NSString*) defaultSubtitle;

@end