//
//  MPDualLabelButton.h
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPDualLabelButton : UIButton

@property UILabel* customTitleLabel;
@property UILabel* subtitleLabel;

//Set color of title and subtitle
- (void) setCombinedTextColor: (UIColor*) textColor;

@end
