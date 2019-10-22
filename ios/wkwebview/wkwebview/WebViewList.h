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

#pragma mark - WebViewList

@interface WebViewList : NSObject

@property(nonatomic, assign) NSInteger activeIndex;
@property(nonatomic, assign, readonly) NSInteger count;

- (NSInteger)getIndexOfWebView:(WebView*)webView;
- (WebView*)webViewAtIndex:(NSInteger)index;

- (void)removeWebView:(WebView*)webView;
- (void)insertWebView:(WebView*)webView AtIndex:(NSInteger)index;
- (void)appendWebView:(WebView*)webView;

// Creates a new WebView and append it to the end of the list.
- (void)createNewWebView;

@end

#pragma mark - Global Vars

WebViewList* GetRegularWebViewList(void);
WebViewList* GetIncognitoWebViewList(void);

#endif /* WebViewList_h */
