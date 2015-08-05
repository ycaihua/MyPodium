//
//  MPFormView.h
//  MyPodium
//
//  Created by Connor Neville on 8/5/15.
//  Copyright © 2015 connorneville. All rights reserved.
//

#import "MPMenuView.h"

@class MPBottomEdgeButton;
@class MPTextField;

@interface MPFormView : MPMenuView

@property NSArray* slideViews;
@property int slideViewIndex;

@property MPBottomEdgeButton* previousButton;
@property MPBottomEdgeButton* nextButton;

- (void) addSlideViews;
- (void) advanceToNextSlide;
- (void) returnToLastSlide;

- (MPView*) slideWithClass: (Class) subviewClass;
- (MPView*) currentSlide;

@end