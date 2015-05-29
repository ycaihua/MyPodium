//
//  MPTextField.h
//  MyPodium
//
//  Created by Connor Neville on 5/14/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPTextField : UITextField

- (id) initWithPlaceholder: (NSString*) text;

+ (float) standardWidth;
+ (float) standardHeight;

@end
