//
//  BarButtonItem.m
//  uikit
//
//  Created by Yi Su on 12/12/18.
//  Copyright © 2018 google. All rights reserved.
//

#import "BarButtonItem.h"

@implementation LeftBarButton

- (instancetype)init {
  self = [super init];
  if (self) {
    UIButton* btn = [UIButton new];
    [btn setTitle:@"left" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn setTitle:@"xxxx" forState:UIControlStateHighlighted];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
    self.customView = btn;
  }
  return self;
}

@end

@implementation RightBarButton

- (instancetype)init {
  self = [super init];
  if (self) {
    UIButton* btn = [UIButton new];
    [btn setTitle:@"right" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn setTitle:@"!!!!!" forState:UIControlStateHighlighted];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
    self.customView = btn;
  }
  return self;
}

@end
