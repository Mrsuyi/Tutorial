//
//  WebView.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebView.h"
#import "../base/LayoutUtils.h"
#import "../base/Observers.h"
#import "UI/UIHandler.h"
#import "WebViewConfiguration.h"
#import "WebsiteDataStore.h"
#import "navigation/NavigationHandler.h"

#define LOG                                                                  \
  NSLog(@"URL: %@ loading: %d cur-URL: %@ init-URL: %@", self.WKWebView.URL, \
        self.WKWebView.loading,                                              \
        self.WKWebView.backForwardList.currentItem.URL,                      \
        self.WKWebView.backForwardList.currentItem.initialURL)

#pragma mark - WebKit Private API

@interface WKPreferences (Private)

@property(nonatomic,
          getter=_isSafeBrowsingEnabled,
          setter=_setSafeBrowsingEnabled:) BOOL _safeBrowsingEnabled;

@end

#pragma mark - WebView

@interface WebView () <NavigationDelegate, UIDelegate>

@property(nonatomic, readwrite) BOOL incognito;
@property(nonatomic, readonly, strong) NavigationHandler* navigationHandler;
@property(nonatomic, readonly, strong) UIHandler* UIHandler;

@end

@implementation WebView {
  Observers<id<WebObserver>>* _observers;
}

- (instancetype)initInIncognitoMode:(BOOL)incognito {
  WKWebViewConfiguration* conf = incognito
                                     ? GetIncognitoWKWebViewConfiguration()
                                     : GetRegularWKWebViewConfiguration();
  self = [self initWithWKWebViewConfiguration:conf];
  if (self) {
    _incognito = incognito;
  }
  return self;
}

- (instancetype)initWithWKWebViewConfiguration:
    (WKWebViewConfiguration*)configuration {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    [configuration.preferences _setSafeBrowsingEnabled:YES];

    _WKWebView = [[WKWebView alloc] initWithFrame:CGRectZero
                                    configuration:configuration];

    // Set up UIHandler.
    _UIHandler = [[UIHandler alloc] init];
    _UIHandler.delegate = self;
    _WKWebView.UIDelegate = _UIHandler;

    // Set up NavigationHandler.
    _navigationHandler = [[NavigationHandler alloc] init];
    _navigationHandler.delegate = self;
    _WKWebView.navigationDelegate = _navigationHandler;

    // Set up KVO.
    _observers = [Observers new];
    for (NSString* key in [self WKWebViewKVOKeyPaths]) {
      [_WKWebView addObserver:self forKeyPath:key options:0 context:nil];
    }

    // Set up views.
    _WKWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_WKWebView];
    [NSLayoutConstraint
        activateConstraints:CreateSameSizeConstraints(self, _WKWebView)];
  }
  return self;
}

#pragma mark - UIHandlerDelegate

- (WKWebView*)webView:(WKWebView*)webView
    createWebViewWithConfiguration:(WKWebViewConfiguration*)configuration
               forNavigationAction:(WKNavigationAction*)navigationAction
                    windowFeatures:(WKWindowFeatures*)windowFeatures {
  WebView* newWebVC =
      [[WebView alloc] initWithWKWebViewConfiguration:configuration];
  newWebVC.incognito = _incognito;
  [_observers notify:@selector(webView:didCreateWebView:)
          withObject:self
          withObject:newWebVC];
  return newWebVC.WKWebView;
}

- (void)webViewDidClose:(WKWebView*)webView {
}

#pragma mark - NSObject

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id>*)change
                       context:(void*)context {
  NSString* callbackName = [self WKWebViewKVOKeyPaths][keyPath];

  // Invoke on |self|.
  SEL sel = NSSelectorFromString(callbackName);
  IMP imp = [self methodForSelector:sel];
  void (*func)(id, SEL) = (void*)imp;
  func(self, sel);

  // Dispatch to observers.
  sel = NSSelectorFromString([NSString stringWithFormat:@"%@:", callbackName]);
  [_observers notify:sel withObject:self];
}

#pragma mark - KVO

- (void)webViewDidChangeURL {
  NSLog(@"KVO-URL");
  LOG;
}

- (void)webViewDidChangeLoading {
  NSLog(@"KVO-loading");
  LOG;
}

- (void)webViewDidChangeTitle {
  NSLog(@"KVO-title");
  LOG;
}

- (void)webViewDidChangeEstimatedProgress {
  NSLog(@"KVO-estimated-progress");
  LOG;
}

- (void)webViewDidChangeCanGoBack {
  NSLog(@"KVO-go-back");
  LOG;
}

- (void)webViewDidChangeCanGoForward {
  NSLog(@"KVO-go-forward");
  LOG;
}

#pragma mark - Public methods

- (void)loadURL:(NSString*)URL {
  NSURL* url = [NSURL URLWithString:URL];
  if (url && !url.scheme) {
    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", URL]];
  }
  NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
  [self.WKWebView loadRequest:request];
}

- (void)loadNTP {
  NSString* path = [NSBundle.mainBundle pathForResource:@"ntp" ofType:@"html"];
  NSURL* url = [NSURL fileURLWithPath:path];
  [self.WKWebView loadFileURL:url allowingReadAccessToURL:url];
}

- (void)addObserver:(id<WebObserver>)delegate {
  [_observers addObserver:delegate];
}

- (void)removeObserver:(id<WebObserver>)delegate {
  [_observers removeObserver:delegate];
}

#pragma mark - Private methods

- (NSDictionary<NSString*, NSString*>*)WKWebViewKVOKeyPaths {
  return @{
    @"title" : @"webViewDidChangeTitle",
    @"URL" : @"webViewDidChangeURL",
    @"estimatedProgress" : @"webViewDidChangeEstimatedProgress",
    @"canGoBack" : @"webViewDidChangeCanGoBack",
    @"canGoForward" : @"webViewDidChangeCanGoForward",
    @"loading" : @"webViewDidChangeLoading",
  };
}

@end
