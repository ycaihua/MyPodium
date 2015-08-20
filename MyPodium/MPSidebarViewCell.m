//
//  MPSidebarViewCell.m
//  MyPodium
//
//  Created by Connor Neville on 5/30/15.
//  Copyright (c) 2015 connorneville. All rights reserved.
//

#import "UIColor+MPColor.h"

#import "MPSidebarViewCell.h"
#import "MPSidebarButton.h"

@implementation MPSidebarViewCell

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

- (void) updateWithRow: (int) row {
    self.cellButton.rowIndex = row;
    self.cellButton.customTitleLabel.text = [MPSidebarViewCell cellLabelStrings][row];
}

- (void) makeControls {
    //self.leadingBorder
    self.leadingBorder = [[UIView alloc] init];
    self.leadingBorder.backgroundColor = [UIColor MPYellowColor];
    self.leadingBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.leadingBorder];
    
    //self.cellButton
    self.cellButton = [[MPSidebarButton alloc] init];
    self.cellButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview: self.cellButton];
}

- (void) makeControlConstraints {
    [self addConstraints: @[//self.leadingBorder
                            [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeadingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:-6.0f],
                            [NSLayoutConstraint constraintWithItem:self.leadingBorder
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0f
                                                          constant:1.0f],
                            //self.cellButton
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.leadingBorder
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.leadingBorder
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1.0f
                                                          constant:0.0f],
                            [NSLayoutConstraint constraintWithItem:self.cellButton
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailingMargin
                                                        multiplier:1.0f
                                                          constant:0.0f]
                            ]];
}

+ (CGFloat) cellHeight { return 50.0f; }

+ (NSArray*) cellLabelStrings {
    return @[@"Home", @"Friends", @"Teams", @"Rules",
             @"Events", @"Messages", @"Search",
             @"Settings", @"Help", @"About",
             @"Log Out"];
}

@end
