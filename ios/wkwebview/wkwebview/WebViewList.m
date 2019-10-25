//
//  WebViewList.m
//  wkwebview
//
//  Created by Yi Su on 10/22/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebViewList.h"
<<<<<<< HEAD
#import "base/ObserverList.h"
=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee

#pragma mark - WebViewList

@interface WebViewList ()

@property(nonatomic, strong) NSMutableArray<WebView*>* webViews;
<<<<<<< HEAD
@property(nonatomic, strong)
    ObserverList<id<WebViewListObserver>>* observerList;
=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee

@end

@implementation WebViewList

<<<<<<< HEAD
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
=======
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
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
  return self.webViews[index];
}

- (void)removeWebView:(WebView*)webView {
<<<<<<< HEAD
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
=======
  [self.webViews removeObject:webView];
}

- (void)insertWebView:(WebView*)webView AtIndex:(NSInteger)index {
  [self.webViews insertObject:webView atIndex:index];
}

- (void)appendWebView:(WebView*)webView {
  [self.webViews insertObject:webView atIndex:self.webViews.count];
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
}

- (void)createNewWebView {
  NSAssert(NO, @"WebViewList.createNewWebView must be overridden");
}

<<<<<<< HEAD
- (void)addObserver:(id<WebViewListObserver>)observer {
  [self.observerList addObserver:observer];
}

- (void)removeObserver:(id<WebViewListObserver>)observer {
  [self.observerList removeObserver:observer];
}

=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
@end

#pragma mark - RegularWebViewList

@interface RegularWebViewList : WebViewList
<<<<<<< HEAD
=======

- (void)createNewWebView;

>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
@end

@implementation RegularWebViewList

<<<<<<< HEAD
- (BOOL)incognito {
  return NO;
}

=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
- (void)createNewWebView {
  WebView* webView = [[WebView alloc] initInIncognitoMode:NO];
  [self appendWebView:webView];
}

@end

#pragma mark -IncognitoWebViewList

@interface IncognitoWebViewList : WebViewList
<<<<<<< HEAD
=======

- (void)createNewWebView;

>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
@end

@implementation IncognitoWebViewList

<<<<<<< HEAD
- (BOOL)incognito {
  return YES;
}

=======
>>>>>>> 2b0ed2b59c7da3e5e2821ebc7c4a45a9c46d11ee
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
