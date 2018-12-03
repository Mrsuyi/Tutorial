//
//  button.m
//  common
//
//  Created by Yi Su on 03/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "button.h"

@implementation Button

- (instancetype)initWithTitle:(NSString*)title frame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.title = title;
    
    [self setTitle:self.title forState:UIControlStateNormal];
    [self setTitle:self.title forState:UIControlStateHighlighted];
    [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
  }
  return self;
}

@end
