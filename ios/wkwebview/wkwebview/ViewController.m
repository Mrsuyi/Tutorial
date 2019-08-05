//
//  ViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/8/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "ViewController.h"
#import "base/LayoutUtils.h"
#import "browser/BrowserViewController.h"
#import "tab_switcher/TabSwitcherViewController.h"
#import "web/WebView.h"
#import "web/WebViewConfiguration.h"

@interface ViewController () <TabSwitcherDelegate, BrowserDelegate, WebObserver>

@property(nonatomic, strong) NSMutableSet<WebView*>* webViews;
@property(nonatomic, strong) TabSwitcherViewController* tabSwitcherVC;
@property(nonatomic, strong) BrowserViewController* browserVC;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    _webViews = [NSMutableSet new];
    _tabSwitcherVC = [TabSwitcherViewController new];
    _tabSwitcherVC.delegate = self;
    _browserVC = [BrowserViewController new];
    _browserVC.delegate = self;
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
  WebView* newTab = [[WebView alloc] initInIncognitoMode:NO];
  [self addAndShowWebView:newTab];
  [newTab loadNTP];
}

#pragma mark - UIViewController

- (void)traitCollectionDidChange:(UITraitCollection*)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
}

#pragma mark - TabSwitcherDelegate

- (void)tabSwitcher:(id)tabSwitcher didSelectTab:(TabModel*)tabModel {
  WebView* webView = (WebView*)tabModel.ID;
  [self.browserVC setWebView:webView];
  [self showBrowserVC];
}

- (void)tabSwitcherDidTapDoneButton:(id)tabSwitcher {
  [self showBrowserVC];
}

- (void)tabSwitcher:(TabSwitcherViewController*)tabSwitcher
    didTapNewTabButtonInIncognitoMode:(BOOL)inIncognitoMode {
  WebView* newTab = [[WebView alloc] initInIncognitoMode:inIncognitoMode];
  [self addAndShowWebView:newTab];
  [newTab loadNTP];
  [self showBrowserVC];
}

- (void)tabSwitcher:(TabSwitcherViewController*)tabSwitcher
       willCloseTab:(TabModel*)tabModel {
  [_webViews removeObject:(WebView*)tabModel.ID];
}

#pragma mark - BrowserDelegate

- (void)browserDidTapTabSwitcherButton:(BrowserViewController*)browser {
  WKWebView* webView = self.browserVC.webView.WKWebView;
  WKSnapshotConfiguration* conf = [[WKSnapshotConfiguration alloc] init];
  __weak ViewController* weakSelf = self;
  [webView
      takeSnapshotWithConfiguration:conf
                  completionHandler:^(UIImage* _Nullable snapshotImage,
                                      NSError* _Nullable error) {
                    if (error) {
                      NSLog(@"WKWebView takeSnapshot failed: %@", error);
                      return;
                    }
                    [weakSelf.tabSwitcherVC
                        updateTabModel:[TabModel
                                           modelWithID:weakSelf.browserVC
                                                           .webView
                                             incognito:weakSelf.browserVC
                                                           .webView.incognito
                                                 title:nil
                                            screenShot:snapshotImage]];
                  }];
  [self hideBrowserVC];
}

#pragma mark - WebObserver

- (void)webView:(WebView*)oldwebView didCreateWebView:(WebView*)newwebView {
  [self addAndShowWebView:newwebView];
}

- (void)webViewDidChangeTitle:(WebView*)webView {
  [self.tabSwitcherVC
      updateTabModel:[TabModel modelWithID:webView
                                 incognito:webView.incognito
                                     title:webView.WKWebView.title
                                screenShot:nil]];
}

- (void)webViewDidStartLoading:(WebView*)webVC {
}

- (void)webViewDidFinishLoading:(WebView*)webVC {
}

#pragma mark - Helper methods

- (void)showBrowserVC {
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

- (void)addAndShowWebView:(WebView*)webView {
  [self.webViews addObject:webView];
  [webView addObserver:self];
  [self.tabSwitcherVC addTabModel:[TabModel modelWithID:webView
                                              incognito:webView.incognito
                                                  title:webView.WKWebView.title
                                             screenShot:nil]];
  [self.browserVC setWebView:webView];
}

@end
