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
- (void)webView:(WebView*)oldWebView didCreateWebView:(WebView*)newWebView;
- (void)webViewDidChangeURL:(WebView*)webView;
- (void)webViewDidChangeLoading:(WebView*)webView;
- (void)webViewDidChangeTitle:(WebView*)webView;
- (void)webViewDidChangeEstimatedProgress:(WebView*)webView;
- (void)webViewDidChangeCanGoBack:(WebView*)webView;
- (void)webViewDidChangeCanGoForward:(WebView*)webView;

@end

@interface WebView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initInIncognitoMode:(BOOL)incognito;

@property(nonatomic, readonly) BOOL incognito;
@property(nonatomic, strong) WKWebView* WKWebView;

- (void)loadURL:(NSString*)URL;
- (void)loadNTP;
- (void)addObserver:(id<WebObserver>)delegate;
- (void)removeObserver:(id<WebObserver>)delegate;

@end

#endif /* WebView_h */
