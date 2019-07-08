//
//  CollectionViewCell.m
//  uikit
//
//  Created by Yi Su on 1/10/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = UIColor.lightGrayColor;
    //    self.backgroundView.alpha = 0.5;
    //    self.backgroundView.backgroundColor = UIColor.lightGrayColor;

    UILabel* label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = UIColor.redColor;
    label.text = @"shit";
    [self.contentView addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
      [label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
      [label.bottomAnchor
          constraintEqualToAnchor:self.contentView.bottomAnchor],
      [label.leadingAnchor
          constraintEqualToAnchor:self.contentView.leadingAnchor],
      [label.trailingAnchor
          constraintEqualToAnchor:self.contentView.trailingAnchor],
    ]];
  }
  return self;
}

@end
