//
//  ViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/8/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "ViewController.h"
#import "base/LayoutUtils.h"
#import "web/WebViewController.h"
#import "browser/BrowserViewController.h"
#import "tab_switcher/TabSwitcherViewController.h"

@interface ViewController ()<TabSwitcherDelegate, BrowserDelegate, WebObserver>

@property(nonatomic, strong)NSMutableSet<WebViewController*>* webVCs;
@property(nonatomic, strong)TabSwitcherViewController* tabSwitcherVC;
@property(nonatomic, strong)BrowserViewController* browserVC;

@end

@implementation ViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    _webVCs = [NSMutableSet new];
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
  [self.view addSubview:self.tabSwitcherVC.view];
  // Add browserVC.
  [self.view addSubview:self.browserVC.view];

  // Init and display first WebVC.
  WebViewController* newTab = [[WebViewController alloc] initInIncognitoMode:NO];
  [self addAndShowWebVC:newTab];
  [newTab loadNTP];
}

#pragma mark - UIViewController

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
}

#pragma mark - TabSwitcherDelegate

- (void)tabSwitcher:(id)tabSwitcher didSelectTab:(TabModel *)tabModel {
  WebViewController* webVC = (WebViewController*)tabModel.ID;
  self.browserVC.webVC = webVC;
  [self showBrowserVC];
}

- (void)tabSwitcherDidTapDoneButton:(id)tabSwitcher {
  [self showBrowserVC];
}

- (void)tabSwitcher:(TabSwitcherViewController *)tabSwitcher didTapNewTabButtonInIncognitoMode:(BOOL)inIncognitoMode {
  WebViewController* newTab = [[WebViewController alloc] initInIncognitoMode:inIncognitoMode];
  [self addAndShowWebVC:newTab];
  [newTab loadNTP];
  [self showBrowserVC];
}

- (void)tabSwitcher:(TabSwitcherViewController *)tabSwitcher willCloseTab:(TabModel *)tabModel {
  [_webVCs removeObject:(WebViewController*)tabModel.ID];
}

#pragma mark - BrowserDelegate

- (void)browserDidTapTabSwitcherButton:(BrowserViewController *)browser {
  WKWebView* webView = self.browserVC.webVC.webView;
  WKSnapshotConfiguration* conf = [[WKSnapshotConfiguration alloc] init];
  __weak ViewController* weakSelf = self;
  [webView takeSnapshotWithConfiguration:conf completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
    if (error) {
      NSLog(@"WKWebView takeSnapshot failed: %@", error);
      return;
    }
    [weakSelf.tabSwitcherVC updateTabModel:[TabModel modelWithID:weakSelf.browserVC.webVC incognito:weakSelf.browserVC.webVC.incognito title:nil screenShot:snapshotImage]];
  }];
  [self hideBrowserVC];
}

#pragma mark - WebDelegate

- (void)webViewController:(WebViewController*)oldWebVC didCreateWebViewController:(WebViewController*)newWebVC {
  [self addAndShowWebVC:newWebVC];
}

- (void)webViewController:(WebViewController *)webVC didChangeTitle:(NSString *)title {
  [self.tabSwitcherVC updateTabModel:[TabModel modelWithID:webVC incognito:webVC.incognito title:title screenShot:nil]];
}

#pragma mark - Helper methods

- (void)showBrowserVC {
  [self.view addSubview:self.browserVC.view];
  [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.browserVC.view.alpha = 1.0;
  } completion:^(BOOL finished) {
  }];
}

- (void)hideBrowserVC {
  [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    self.browserVC.view.alpha = 0.0;
  } completion:^(BOOL finished) {
    [self.browserVC.view removeFromSuperview];
  }];
}

- (void)addAndShowWebVC:(WebViewController*)webVC {
  [self.webVCs addObject:webVC];
  [webVC addObserver:self];
  [self.tabSwitcherVC addTabModel:[TabModel modelWithID:webVC incognito:webVC.incognito title:webVC.title screenShot:nil]];
  self.browserVC.webVC = webVC;
}

@end
