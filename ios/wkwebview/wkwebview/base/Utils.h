//
//  LayoutUtils.hh
//  wkwebview
//
//  Created by Yi Su on 14/04/2019.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef LayoutUtils_h
#define LayoutUtils_h

#import <WebKit/WebKit.h>

NSArray<NSLayoutConstraint*>* CreateSameSizeConstraints(UIView* view1,
                                                        UIView* view2);

NSString* SimplifyFilePath(NSString* path);

void Log(WKWebView* webView);

#endif /* LayoutUtils_h */
