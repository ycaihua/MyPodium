//
//  MPImageButton.h
//  MyPodium
//
//  Created by Connor Neville on 6/5/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPImageButton : UIButton

//Applies image effects based on string.
//Example image strings:
//info_green
//arrow_yellow
- (void) setImageString: (NSString*) imageString;

@end
