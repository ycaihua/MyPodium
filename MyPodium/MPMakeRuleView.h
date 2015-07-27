//
//  MPMakeRuleView.h
//  MyPodium
//
//  Created by Connor Neville on 7/22/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPBottomEdgeButton;

@interface MPMakeRuleView : MPMenuView

@property NSArray* modeSubviews;
@property int subviewIndex;

@property MPBottomEdgeButton* previousButton;
@property MPBottomEdgeButton* nextButton;

- (void) advanceToNextSubview;
- (void) returnToLastSubview;

@end
