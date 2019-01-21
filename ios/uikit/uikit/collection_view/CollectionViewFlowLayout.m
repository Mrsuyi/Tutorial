//
//  CollectionViewLayout.m
//  uikit
//
//  Created by Yi Su on 1/10/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout

- (instancetype)init {
  self = [super init];
  if (self) {
    self.itemSize = CGSizeMake(50, 30);
  }
  return self;
}

@end
