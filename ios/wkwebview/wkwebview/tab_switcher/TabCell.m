//
//  TabCell.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TabCell {
  UIStackView* _header;
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = UIColor.lightGrayColor;

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font =
        [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    _titleLabel.adjustsFontForContentSizeCategory = YES;

    _closeButton = [[UIButton alloc] init];
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_closeButton setTitle:@"X" forState:UIControlStateNormal];
    _closeButton.titleLabel.font =
        [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    _closeButton.titleLabel.adjustsFontForContentSizeCategory = YES;
    [_closeButton setContentHuggingPriority:UILayoutPriorityRequired
                                    forAxis:UILayoutConstraintAxisHorizontal];
    [_closeButton addTarget:self
                     action:@selector(didTapCloseButton:)
           forControlEvents:UIControlEventTouchUpInside];

    _header = [[UIStackView alloc]
        initWithArrangedSubviews:@[ _titleLabel, _closeButton ]];
    _header.translatesAutoresizingMaskIntoConstraints = NO;
    _header.alignment = UIStackViewAlignmentCenter;
    _header.axis = UILayoutConstraintAxisHorizontal;

    _screenShotView = [UIImageView new];
    _screenShotView.translatesAutoresizingMaskIntoConstraints = NO;
    _screenShotView.contentMode = UIViewContentModeScaleAspectFill;

    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:_header];
    [self.contentView addSubview:_screenShotView];
    [NSLayoutConstraint activateConstraints:@[
      [_header.leadingAnchor
          constraintEqualToAnchor:self.contentView.leadingAnchor],
      [_header.trailingAnchor
          constraintEqualToAnchor:self.contentView.trailingAnchor],
      [_header.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
      [_header.bottomAnchor constraintEqualToAnchor:_screenShotView.topAnchor],
      //
      [_screenShotView.leadingAnchor
          constraintEqualToAnchor:self.contentView.leadingAnchor],
      [_screenShotView.trailingAnchor
          constraintEqualToAnchor:self.contentView.trailingAnchor],
      [_screenShotView.bottomAnchor
          constraintEqualToAnchor:self.contentView.bottomAnchor],
    ]];
  }
  return self;
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    self.contentView.layer.borderColor = UIColor.orangeColor.CGColor;
    self.contentView.layer.borderWidth = 3.0f;
  } else {
    self.contentView.layer.borderColor = UIColor.clearColor.CGColor;
    self.contentView.layer.borderWidth = 0.0f;
  }
}

#pragma mark - Public

- (void)setIncognito:(BOOL)incognito {
  _incognito = incognito;
  if (incognito) {
    self.contentView.backgroundColor = UIColor.darkGrayColor;
    self.titleLabel.textColor = UIColor.whiteColor;
    [self.closeButton setTitleColor:UIColor.whiteColor
                           forState:UIControlStateNormal];
    [self.closeButton setTitleColor:UIColor.lightGrayColor
                           forState:UIControlStateHighlighted];
  } else {
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.titleLabel.textColor = UIColor.blackColor;
    [self.closeButton setTitleColor:UIColor.blackColor
                           forState:UIControlStateNormal];
    [self.closeButton setTitleColor:UIColor.lightGrayColor
                           forState:UIControlStateHighlighted];
  }
}

- (void)didTapCloseButton:(UIButton*)button {
  [self.delegate tabCellDidTapCloseButton:self];
}

@end
