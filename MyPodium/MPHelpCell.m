//
//  MPHelpCell.m
//  MyPodium
//
//  Created by Connor Neville on 6/6/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "MPHelpCell.h"
#import "MPLabel.h"

@implementation MPHelpCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self removeExistingSubviews];
        [self makeControls];
        [self makeControlConstraints];
    }
    return self;
    
}

- (void) removeExistingSubviews {
    for(UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void) makeControls {
    self.bodyLabel = [[MPLabel alloc] init];
    self.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.font = [UIFont fontWithName:@"Lato-Regular" size:13.0f];
    [self addSubview: self.bodyLabel];
}

- (void) makeControlConstraints {
    [self addConstraints:@[//self.bodyLabel
                           [NSLayoutConstraint constraintWithItem:self.bodyLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTopMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottomMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeadingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.bodyLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailingMargin
                                                       multiplier:1.0f
                                                         constant:0.0f]
                           ]];
}

@end
