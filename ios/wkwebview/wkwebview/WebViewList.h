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

<<<<<<< HEAD
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

=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
#pragma mark - WebViewList

@interface WebViewList : NSObject

<<<<<<< HEAD
@property(nonatomic, assign) NSUInteger activeIndex;
@property(nonatomic, assign, readonly) NSUInteger count;
@property(nonatomic, assign, readonly) BOOL incognito;

- (NSUInteger)indexOfWebView:(WebView*)webView;
- (WebView*)webViewAtIndex:(NSUInteger)index;

- (void)removeWebView:(WebView*)webView;
- (void)removeWebViewAtIndex:(NSUInteger)index;
- (void)insertWebView:(WebView*)webView atIndex:(NSInteger)index;
=======
@property(nonatomic, assign) NSInteger activeIndex;
@property(nonatomic, assign, readonly) NSInteger count;

- (NSInteger)getIndexOfWebView:(WebView*)webView;
- (WebView*)webViewAtIndex:(NSInteger)index;

- (void)removeWebView:(WebView*)webView;
- (void)insertWebView:(WebView*)webView AtIndex:(NSInteger)index;
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
- (void)appendWebView:(WebView*)webView;

// Creates a new WebView and append it to the end of the list.
- (void)createNewWebView;

<<<<<<< HEAD
- (void)addObserver:(id<WebViewListObserver>)observer;
- (void)removeObserver:(id<WebViewListObserver>)observer;

=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
@end

#pragma mark - Global Vars

WebViewList* GetRegularWebViewList(void);
WebViewList* GetIncognitoWebViewList(void);

#endif /* WebViewList_h */
