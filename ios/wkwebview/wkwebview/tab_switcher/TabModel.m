//
//  TabModel.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TabModel.h"

@implementation TabModel

+ (instancetype)modelWithWebView:(WebView*)webView {
  TabModel* model = [[TabModel alloc] init];
  model.webView = webView;
  return model;
}

@end
