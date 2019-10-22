//
//  WebViewList.m
//  wkwebview
//
//  Created by Yi Su on 10/22/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebViewList.h"
#import "base/ObserverList.h"

#pragma mark - WebViewList

@interface WebViewList ()

@property(nonatomic, strong) NSMutableArray<WebView*>* webViews;
@property(nonatomic, strong)
    ObserverList<id<WebViewListObserver>>* observerList;

@end

@implementation WebViewList

- (instancetype)init {
  if (self = [super init]) {
    _webViews = [[NSMutableArray alloc] init];
    _observerList = [[ObserverList alloc] init];
  }
  return self;
}

- (void)setActiveIndex:(NSUInteger)activeIndex {
  NSAssert((0 <= activeIndex && activeIndex < self.webViews.count) ||
               activeIndex == NSNotFound,
           @"activeIndex must be valid");
  _activeIndex = activeIndex;
  WebView* webView =
      activeIndex == NSNotFound ? nil : self.webViews[activeIndex];
  [self.observerList notify:@selector(webViewList:didActivateWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:activeIndex];
}

- (NSUInteger)count {
  return self.webViews.count;
}

- (BOOL)incognito {
  NSAssert(NO, @"WebViewList.incognito must be overridden");
  return NO;
}

- (NSUInteger)indexOfWebView:(WebView*)webView {
  return [self.webViews indexOfObject:webView];
}

- (WebView*)webViewAtIndex:(NSUInteger)index {
  return self.webViews[index];
}

- (void)removeWebView:(WebView*)webView {
  NSUInteger index = [self.webViews indexOfObject:webView];
  if (index == NSNotFound) {
    return;
  }
  [self.observerList notify:@selector(webViewList:willRemoveWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:index];
  [self.webViews removeObjectAtIndex:index];
  [self.observerList notify:@selector(webViewList:didRemoveWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:index];
}

- (void)removeWebViewAtIndex:(NSUInteger)index {
  [self.observerList notify:@selector(webViewList:willRemoveWebView:atIndex:)
                 withObject:self
                 withObject:self.webViews[index]
               withUInteger:index];
  [self.webViews removeObjectAtIndex:index];
}

- (void)insertWebView:(WebView*)webView atIndex:(NSInteger)index {
  [self.webViews insertObject:webView atIndex:index];
  [self.observerList notify:@selector(webViewList:didInsertWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:index];
}

- (void)appendWebView:(WebView*)webView {
  [self insertWebView:webView atIndex:self.webViews.count];
}

- (void)createNewWebView {
  NSAssert(NO, @"WebViewList.createNewWebView must be overridden");
}

- (void)addObserver:(id<WebViewListObserver>)observer {
  [self.observerList addObserver:observer];
}

- (void)removeObserver:(id<WebViewListObserver>)observer {
  [self.observerList removeObserver:observer];
}

@end

#pragma mark - RegularWebViewList

@interface RegularWebViewList : WebViewList
@end

@implementation RegularWebViewList

- (BOOL)incognito {
  return NO;
}

- (void)createNewWebView {
  WebView* webView = [[WebView alloc] initInIncognitoMode:NO];
  [self appendWebView:webView];
}

@end

#pragma mark -IncognitoWebViewList

@interface IncognitoWebViewList : WebViewList
@end

@implementation IncognitoWebViewList

- (BOOL)incognito {
  return YES;
}

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
