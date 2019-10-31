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
    _activeIndex = NSNotFound;
  }
  return self;
}

- (void)setActiveIndex:(NSUInteger)activeIndex {
  NSAssert((0 <= activeIndex && activeIndex < self.webViews.count) ||
               activeIndex == NSNotFound,
           @"activeIndex must be valid");
  WebView* deactiveWebView =
      _activeIndex == NSNotFound ? nil : self.webViews[_activeIndex];
  WebView* activeWebView =
      activeIndex == NSNotFound ? nil : self.webViews[activeIndex];
  NSUInteger deactiveIndex = _activeIndex;
  [self.observerList
            notify:@selector(webViewList:
                       willActivateWebView:atIndex:deactivateWebView:atIndex:)
        withObject:self
        withObject:activeWebView
      withUInteger:activeIndex
        withObject:deactiveWebView
      withUInteger:deactiveIndex];
  _activeIndex = activeIndex;
  [self.observerList
            notify:@selector(webViewList:
                       didActivateWebView:atIndex:deactiveWebView:atIndex:)
        withObject:self
        withObject:activeWebView
      withUInteger:activeIndex
        withObject:deactiveWebView
      withUInteger:deactiveIndex];
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

- (WebView*)objectAtIndexedSubscript:(NSUInteger)index {
  return self.webViews[index];
}

- (void)removeWebView:(WebView*)webView {
  if (!webView) {
    return;
  }
  NSUInteger index = [self.webViews indexOfObject:webView];
  NSAssert(index != NSNotFound, @"webview should exist");
  [self removeWebView:webView atIndex:index];
}

- (void)removeWebViewAtIndex:(NSUInteger)index {
  if (index == NSNotFound) {
    return;
  }
  NSAssert(index < self.count, @"index should be valid");
  [self removeWebView:self.webViews[index] atIndex:index];
}

- (void)insertWebView:(WebView*)webView atIndex:(NSInteger)index {
  [self.observerList notify:@selector(webViewList:willInsertWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:index];
  [self.webViews insertObject:webView atIndex:index];
  if (_activeIndex != NSNotFound && _activeIndex >= index) {
    _activeIndex += 1;
  }
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

#pragma mark - Private

- (void)removeWebView:(WebView*)webView atIndex:(NSUInteger)index {
  if (index == _activeIndex) {
    NSUInteger count = self.count;
    if (count > index + 1) {
      self.activeIndex = index + 1;
    } else if (index > 0) {
      self.activeIndex = index - 1;
    } else {
      self.activeIndex = NSNotFound;
    }
  }
  [self.observerList notify:@selector(webViewList:willRemoveWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:index];
  [self.webViews removeObjectAtIndex:index];
  if (_activeIndex != NSNotFound && _activeIndex > index) {
    _activeIndex -= 1;
  }
  [self.observerList notify:@selector(webViewList:didRemoveWebView:atIndex:)
                 withObject:self
                 withObject:webView
               withUInteger:index];
}

@end

#pragma mark - RegularWebViewList

@interface RegularWebViewList : WebViewList
@end

@implementation RegularWebViewList

- (BOOL)incognito {
  return NO;
}

@end

#pragma mark -IncognitoWebViewList

@interface IncognitoWebViewList : WebViewList
@end

@implementation IncognitoWebViewList

- (BOOL)incognito {
  return YES;
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
