//
//  UIHandler.h
//  wkwebview
//
//  Created by Yi Su on 8/5/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef UIHandler_h
#define UIHandler_h

#import <WebKit/WebKit.h>

@protocol UIDelegate

- (WKWebView*)webView:(WKWebView*)webView
    createWebViewWithConfiguration:(WKWebViewConfiguration*)configuration
               forNavigationAction:(WKNavigationAction*)navigationAction
                    windowFeatures:(WKWindowFeatures*)windowFeatures;

- (void)webViewDidClose:(WKWebView*)webView;

@end

@interface UIHandler : NSObject <WKUIDelegate>

@property(nonatomic, weak) id<UIDelegate> delegate;

@end

#endif /* UIHandler_h */
