//
//  WebViewList.m
//  wkwebview
//
//  Created by Yi Su on 10/22/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebViewList.h"

#pragma mark - WebViewList

@interface WebViewList ()

@property(nonatomic, strong) NSMutableArray<WebView*>* webViews;

@end

@implementation WebViewList

- (void)setActiveIndex:(NSInteger)activeIndex {
  _activeIndex = activeIndex;
}

- (NSInteger)count {
  return self.webViews.count;
}

- (NSInteger)getIndexOfWebView:(WebView*)webView {
  for (NSInteger i = 0; i < self.webViews.count; ++i) {
    if (self.webViews[i] == webView) {
      return i;
    }
  }
  return -1;
}

- (WebView*)webViewAtIndex:(NSInteger)index {
  return self.webViews[index];
}

- (void)removeWebView:(WebView*)webView {
  [self.webViews removeObject:webView];
}

- (void)insertWebView:(WebView*)webView AtIndex:(NSInteger)index {
  [self.webViews insertObject:webView atIndex:index];
}

- (void)appendWebView:(WebView*)webView {
  [self.webViews insertObject:webView atIndex:self.webViews.count];
}

- (void)createNewWebView {
  NSAssert(NO, @"WebViewList.createNewWebView must be overridden");
}

@end

#pragma mark - RegularWebViewList

@interface RegularWebViewList : WebViewList

- (void)createNewWebView;

@end

@implementation RegularWebViewList

- (void)createNewWebView {
  WebView* webView = [[WebView alloc] initInIncognitoMode:NO];
  [self appendWebView:webView];
}

@end

#pragma mark -IncognitoWebViewList

@interface IncognitoWebViewList : WebViewList

- (void)createNewWebView;

@end

@implementation IncognitoWebViewList

- (void)createNewWebView {
  WebView* webView = [[WebView alloc] initInIncognitoMode:YES];
  [self appendWebView:webView];
}

@end

#pragma mark - Global Vars

RegularWebViewList* kRegularWebViewList = nil;
IncognitoWebViewList* kIncognitoWebViewList = nil;

WebViewList* GetRegularWebViewList() {
  if (!kRegularWebViewList) {
    kRegularWebViewList = [[RegularWebViewList alloc] init];
  }
  return kRegularWebViewList;
}

WebViewList* GetIncognitoWebViewList() {
  if (!kIncognitoWebViewList) {
    kIncognitoWebViewList = [[IncognitoWebViewList alloc] init];
  }
  return kIncognitoWebViewList;
}
