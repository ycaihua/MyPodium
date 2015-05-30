//
//  MPDualLabelButton
//  MyPodium
//
//  Created by Connor Neville on 5/29/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPDualLabelButton.h"

@implementation MPDualLabelButton

- (id) init {
    self = [super init];
    if(self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleLabel removeFromSuperview];
        [self makeControls];
    }
    return self;
}

- (void) setCombinedTextColor: (UIColor*) textColor {
    self.customTitleLabel.textColor = textColor;
    self.subtitleLabel.textColor = textColor;
}

- (void) makeControls {
    //self.customTitleLabel
    self.customTitleLabel = [[UILabel alloc] init];
    self.customTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.customTitleLabel.numberOfLines = 1;
    self.customTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.customTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.customTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.customTitleLabel.minimumScaleFactor = 0.3f;
    [self addSubview: self.customTitleLabel];
    
    //self.subtitleLabel
    self.subtitleLabel = [[UILabel alloc] init];
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitleLabel.numberOfLines = 1;
    self.subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.adjustsFontSizeToFitWidth = YES;
    self.subtitleLabel.minimumScaleFactor = 0.3f;
    [self addSubview: self.subtitleLabel];
}
@end
