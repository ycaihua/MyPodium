//
//  MPView.h
//  MyPodium
//
//  Base class for all views in MyPodium,
//  containing any subviews or behaviors used in
//  all other view subclasses.
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPView : UIView

//Button that sits in the back of the
//view to dismiss any keyboards on tap
@property UIButton* responderButton;

- (id) init;

@end