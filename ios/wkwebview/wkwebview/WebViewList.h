//
//  WebViewList.h
//  wkwebview
//
//  Created by Yi Su on 10/22/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WebViewList_h
#define WebViewList_h

#import "web/WebView.h"

@class WebViewList;

#pragma mark - WebViewListObserver

@protocol WebViewListObserver <NSObject>

@optional

- (void)webViewList:(WebViewList*)webViewList
    didInsertWebView:(WebView*)webView
             atIndex:(NSUInteger)index;
- (void)webViewList:(WebViewList*)webViewList
    willRemoveWebView:(WebView*)webView
              atIndex:(NSUInteger)index;
- (void)webViewList:(WebViewList*)webViewList
    didRemoveWebView:(WebView*)webView
             atIndex:(NSUInteger)index;
- (void)webViewList:(WebViewList*)webViewlist
    didActivateWebView:(WebView*)webView
               atIndex:(NSUInteger)index;

@end

#pragma mark - WebViewList

@interface WebViewList : NSObject

@property(nonatomic, assign) NSUInteger activeIndex;
@property(nonatomic, assign, readonly) NSUInteger count;
@property(nonatomic, assign, readonly) BOOL incognito;

- (NSUInteger)indexOfWebView:(WebView*)webView;
- (WebView*)webViewAtIndex:(NSUInteger)index;

- (void)removeWebView:(WebView*)webView;
- (void)removeWebViewAtIndex:(NSUInteger)index;
- (void)insertWebView:(WebView*)webView atIndex:(NSInteger)index;
- (void)appendWebView:(WebView*)webView;

// Creates a new WebView and append it to the end of the list.
- (void)createNewWebView;

- (void)addObserver:(id<WebViewListObserver>)observer;
- (void)removeObserver:(id<WebViewListObserver>)observer;

@end

#pragma mark - Global Vars

WebViewList* GetRegularWebViewList(void);
WebViewList* GetIncognitoWebViewList(void);

#endif /* WebViewList_h */
