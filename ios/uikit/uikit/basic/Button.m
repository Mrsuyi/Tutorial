//
//  Button.m
//  uikit
//
//  Created by Yi Su on 1/14/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "Button.h"

@implementation Button

- (instancetype)init {
  self = [super init];
  if (self) {
    self.backgroundColor = UIColor.blueColor;

    self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);

    UIImage* image = [UIImage imageNamed:@"m.png"];
//    self.imageView.image = image;
    [self setImage:image forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  return self;
}

@end
