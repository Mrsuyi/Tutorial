//
//  LayoutUtils.m
//  wkwebview
//
//  Created by Yi Su on 14/04/2019.
//  Copyright © 2019 google. All rights reserved.
//

#import "LayoutUtils.h"

NSArray<NSLayoutConstraint*>* CreateSameSizeConstraints(UIView* view1, UIView* view2) {
  return @[[view1.topAnchor constraintEqualToAnchor:view2.topAnchor],
           [view1.bottomAnchor constraintEqualToAnchor:view2.bottomAnchor],
           [view1.leadingAnchor constraintEqualToAnchor:view2.leadingAnchor],
           [view1.trailingAnchor constraintEqualToAnchor:view2.trailingAnchor]];
}
