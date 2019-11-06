//
//  LayoutUtils.hh
//  wkwebview
//
//  Created by Yi Su on 14/04/2019.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef LayoutUtils_h
#define LayoutUtils_h

#import <UIKit/UIKit.h>

NSArray<NSLayoutConstraint*>* CreateSameSizeConstraints(UIView* view1,
                                                        UIView* view2);

NSString* SimplifyFilePath(NSString* path);

#define LOG(webView)                                                           \
  do {                                                                         \
    NSString* URL = SimplifyFilePath(webView.URL.absoluteString);              \
    NSString* curURL = SimplifyFilePath(                                       \
        webView.backForwardList.currentItem.URL.absoluteString);               \
    NSString* initURL = SimplifyFilePath(                                      \
        webView.backForwardList.currentItem.initialURL.absoluteString);        \
    NSLog(@"loading: %d URL: %@ curURL: %@ initURL: %@", webView.loading, URL, \
          curURL, initURL);                                                    \
  } while (0)

#endif /* LayoutUtils_h */
