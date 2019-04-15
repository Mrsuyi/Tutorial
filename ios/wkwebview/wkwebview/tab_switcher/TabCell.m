//
//  TabCell.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TabCell

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = UIColor.lightGrayColor;

    _titleLabel = [UILabel new];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.backgroundColor = UIColor.whiteColor;
    _titleLabel.textColor = UIColor.blackColor;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];

    _screenShotView = [UIImageView new];
    _screenShotView.translatesAutoresizingMaskIntoConstraints = NO;
    _screenShotView.contentMode = UIViewContentModeScaleAspectFit;

    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:_screenShotView];
    [self.contentView addSubview:_titleLabel];
    [NSLayoutConstraint activateConstraints:@[[_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                              [_titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
                                              [_titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [_titleLabel.bottomAnchor constraintEqualToAnchor:_screenShotView.topAnchor],
                                              //
                                              [_screenShotView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                              [_screenShotView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
                                              [_screenShotView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],]];
  }
  return self;
}

@end
