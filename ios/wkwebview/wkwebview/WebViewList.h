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
    willInsertWebView:(WebView*)webView
              atIndex:(NSUInteger)index;
- (void)webViewList:(WebViewList*)webViewList
    didInsertWebView:(WebView*)webView
             atIndex:(NSUInteger)index;
- (void)webViewList:(WebViewList*)webViewList
    willRemoveWebView:(WebView*)webView
              atIndex:(NSUInteger)index;
- (void)webViewList:(WebViewList*)webViewList
    didRemoveWebView:(WebView*)webView
             atIndex:(NSUInteger)index;
// Might be invoked with index1==index2.
- (void)webViewList:(WebViewList*)webViewList
    willActivateWebView:(WebView*)webView1
                atIndex:(NSUInteger)index1
      deactivateWebView:(WebView*)webView2
                atIndex:(NSUInteger)index2;
- (void)webViewList:(WebViewList*)webViewlist
    didActivateWebView:(WebView*)webView1
               atIndex:(NSUInteger)index1
       deactiveWebView:(WebView*)webView2
               atIndex:(NSUInteger)index2;

@end

#pragma mark - WebViewList

@interface WebViewList : NSObject

// activeIndex must be assignd with a valid value [0, count), or NSNotFound.
@property(nonatomic, assign) NSUInteger activeIndex;
@property(nonatomic, assign, readonly) NSUInteger count;
@property(nonatomic, assign, readonly) BOOL incognito;

- (NSUInteger)indexOfWebView:(WebView*)webView;
- (WebView*)objectAtIndexedSubscript:(NSUInteger)index;

- (void)insertWebView:(WebView*)webView atIndex:(NSInteger)index;
- (void)appendWebView:(WebView*)webView;
// Remove active webView will update the activeIndex:
//   1. To next webView after current one;
//   2. To previous one if current one is the last one;
//   3. To NSNotFound if none exists after removal.
- (void)removeWebView:(WebView*)webView;
- (void)removeWebViewAtIndex:(NSUInteger)index;

- (void)addObserver:(id<WebViewListObserver>)observer;
- (void)removeObserver:(id<WebViewListObserver>)observer;

@end

#pragma mark - Global Vars

WebViewList* GetRegularWebViewList(void);
WebViewList* GetIncognitoWebViewList(void);

#endif /* WebViewList_h */
