//
//  TabModel.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef TabModel_h
#define TabModel_h

#import <UIKit/UIKit.h>
#import "../web/WebView.h"

@interface TabModel : NSObject

+ (instancetype)modelWithWebView:(WebView*)webView;

@property(nonatomic, weak) WebView* webView;
@property(nonatomic, strong) UIImage* screenShot;

@end

#endif /* TabModel_h */
