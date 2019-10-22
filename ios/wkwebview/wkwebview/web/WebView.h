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

#pragma mark - WebViewObserver

@protocol WebViewObserver <NSObject>

@optional
- (void)webViewDidChangeURL:(WebView*)webView;
- (void)webViewDidChangeLoading:(WebView*)webView;
- (void)webViewDidChangeTitle:(WebView*)webView;
- (void)webViewDidChangeEstimatedProgress:(WebView*)webView;
- (void)webViewDidChangeCanGoBack:(WebView*)webView;
- (void)webViewDidChangeCanGoForward:(WebView*)webView;

@end

#pragma mark - WebViewDelegate

@protocol WebViewDelegate <NSObject>

@optional

- (void)webView:(WebView*)oldWebView didCreateWebView:(WebView*)newWebView;
- (void)webViewDidClose:(WebView*)webView;

@end

#pragma mark - WebView

@interface WebView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initInIncognitoMode:(BOOL)incognito;

@property(nonatomic, readonly) BOOL incognito;
@property(nonatomic, strong) WKWebView* WKWebView;
@property(nonatomic, weak) id<WebViewDelegate> delegate;

- (void)loadURL:(NSString*)URL;
- (void)loadNTP;
- (void)addObserver:(id<WebViewObserver>)delegate;
- (void)removeObserver:(id<WebViewObserver>)delegate;

@end

#endif /* WebView_h */
