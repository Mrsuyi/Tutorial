//
//  ViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/8/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "ViewController.h"
#import "WebViewList.h"
#import "base/Utils.h"
#import "browser/BrowserViewController.h"
#import "tab_switcher/TabSwitcherViewController.h"
#import "web/WebView.h"
#import "web/WebViewConfiguration.h"

@interface ViewController () <TabSwitcherDelegate,
                              BrowserDelegate,
                              WebViewDelegate,
                              WebViewObserver,
                              WebViewListObserver>

@property(nonatomic, strong) TabSwitcherViewController* tabSwitcherVC;
@property(nonatomic, strong) BrowserViewController* browserVC;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    WebViewList* regularWebViewList = GetRegularWebViewList();
    WebViewList* incognitoWebViewList = GetIncognitoWebViewList();

    _tabSwitcherVC = [TabSwitcherViewController new];
    _tabSwitcherVC.delegate = self;
    [regularWebViewList addObserver:_tabSwitcherVC];
    [incognitoWebViewList addObserver:_tabSwitcherVC];

    _browserVC = [BrowserViewController new];
    _browserVC.delegate = self;
    [regularWebViewList addObserver:_browserVC];
    [incognitoWebViewList addObserver:_browserVC];

    [regularWebViewList addObserver:self];
    [incognitoWebViewList addObserver:self];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Add TabSwitcherVC.
  [self addChildViewController:self.tabSwitcherVC];
  [self.view addSubview:self.tabSwitcherVC.view];
  // Add browserVC.
  [self addChildViewController:self.browserVC];
  [self.view addSubview:self.browserVC.view];

  // Init and display first webView.
  WebView* newWebView = [[WebView alloc] initInIncognitoMode:NO];
  newWebView.delegate = self;
  WebViewList* webViewList = GetRegularWebViewList();
  [webViewList appendWebView:newWebView];
  webViewList.activeIndex = webViewList.count - 1;
  [newWebView loadNTP];
}

#pragma mark - UIViewController

- (void)traitCollectionDidChange:(UITraitCollection*)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
}

#pragma mark - TabSwitcherDelegate

- (void)tabSwitcher:(TabSwitcherViewController*)tabSwitcher
    didSelectWebView:(WebView*)webView {
  [self showBrowserVC];
}

- (void)tabSwitcherDidTapDoneButton:(id)tabSwitcher {
  [self showBrowserVC];
}

- (void)tabSwitcher:(TabSwitcherViewController*)tabSwitcher
    didTapNewTabButtonInIncognitoMode:(BOOL)inIncognitoMode {
  WebView* newWebView = [[WebView alloc] initInIncognitoMode:inIncognitoMode];
  newWebView.delegate = self;
  WebViewList* webViewList =
      inIncognitoMode ? GetIncognitoWebViewList() : GetRegularWebViewList();
  [webViewList appendWebView:newWebView];
  webViewList.activeIndex = webViewList.count - 1;
  [newWebView loadNTP];
  [self showBrowserVC];
}

#pragma mark - BrowserDelegate

- (void)browserDidTapTabSwitcherButton:(BrowserViewController*)browser {
  [self hideBrowserVC];
  [self.tabSwitcherVC updateWebViewScreenShot:browser.webView];
}

#pragma mark - WebViewDelegate

- (void)webView:(WebView*)oldWebView didCreateWebView:(WebView*)newWebView {
  NSAssert(newWebView, @"newly created WebView is nil");
  WebViewList* webViewList = newWebView.incognito ? GetIncognitoWebViewList()
                                                  : GetRegularWebViewList();
  [webViewList appendWebView:newWebView];
  webViewList.activeIndex = webViewList.count - 1;
}

- (void)webViewDidClose:(WebView*)webView {
  [webView removeObserver:self];
  if (webView.incognito) {
    [GetIncognitoWebViewList() removeWebView:webView];
  } else {
    [GetRegularWebViewList() removeWebView:webView];
  }
}

#pragma mark - WebViewObserver

- (void)webViewDidFinishNavigation:(WebView*)webView withError:(NSError*)error {
  if ([self.tabSwitcherVC parentViewController]) {
    [self.tabSwitcherVC updateWebViewScreenShot:webView];
  }
}

#pragma mark - WebViewListObserver

- (void)webViewList:(WebViewList*)webViewList
    didInsertWebView:(WebView*)webView
             atIndex:(NSUInteger)index {
  [webView addObserver:self];
}

- (void)webViewList:(WebViewList*)webViewList
    willRemoveWebView:(WebView*)webView
              atIndex:(NSUInteger)index {
  [webView removeObserver:self];
}

#pragma mark - Helper methods

- (void)showBrowserVC {
  if (self.browserVC.parentViewController) {
    return;
  }
  [self addChildViewController:self.browserVC];
  [self.view addSubview:self.browserVC.view];
  [UIView animateWithDuration:0.25
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     self.browserVC.view.alpha = 1.0;
                   }
                   completion:^(BOOL finished){
                   }];
}

- (void)hideBrowserVC {
  if (!self.browserVC.parentViewController) {
    return;
  }
  [UIView animateWithDuration:0.25
      delay:0
      options:UIViewAnimationOptionCurveEaseIn
      animations:^{
        self.browserVC.view.alpha = 0.0;
      }
      completion:^(BOOL finished) {
        [self.browserVC.view removeFromSuperview];
        [self.browserVC removeFromParentViewController];
      }];
}

@end
