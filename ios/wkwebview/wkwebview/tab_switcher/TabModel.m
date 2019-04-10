//
//  TabModel.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabModel.h"

@implementation TabModel

+ (instancetype)modelWithID:(NSInteger)ID title:(NSString*)title screenShot:(UIImage*)screenShot {
  TabModel* model = [TabModel new];
  model.ID = ID;
  model.title = title;
  model.screenShot = screenShot;
  return model;
}

@end
