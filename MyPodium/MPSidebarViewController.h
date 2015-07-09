//
//  MPSidebarViewController.h
//  MyPodium
//
//  Created by Connor Neville on 5/16/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPSidebarViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

+ (NSString*) sidebarReuseIdentifier;

- (void) refresh;

@end
