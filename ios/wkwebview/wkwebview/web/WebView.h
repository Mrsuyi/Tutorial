//
//  WebView.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WebView_h
#define WebView_h

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class WebView;

@protocol WebObserver <NSObject>

@optional
- (void)WebView:(WebView*)WebVC didCreateWebView:(WebView*)newWebVC;
- (void)WebViewDidChangeURL:(WebView*)webVC;
- (void)WebViewDidChangeTitle:(WebView*)webVC;
- (void)WebViewDidChangeEstimatedProgress:(WebView*)webVC;
- (void)WebViewDidChangeCanGoBack:(WebView*)webVC;
- (void)WebViewDidChangeCanGoForward:(WebView*)webVC;
- (void)WebViewDidStartLoading:(WebView*)webVC;
- (void)WebViewDidFinishLoading:(WebView*)webVC;

@end

@interface WebView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initInIncognitoMode:(BOOL)incognito;

@property(nonatomic, readonly) BOOL incognito;
@property(nonatomic, strong) WKWebView* WKWebView;

- (void)loadNTP;
- (void)addObserver:(id<WebObserver>)delegate;
- (void)removeObserver:(id<WebObserver>)delegate;

@end

#endif /* WebView_h */
