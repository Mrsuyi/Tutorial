//
//  ViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/8/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "ViewController.h"
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

  [self.view addSubview:self.browserVC.view];

  // Init and display first WebVC.
  [self addAndShowWebVC:[self createNtp]];
}

#pragma mark - UIViewController

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
}

#pragma mark - TabSwitcherDelegate

- (void)tabSwitcher:(id)tabSwitcher didSelectTab:(TabModel *)tabModel {
  [self dismissViewControllerAnimated:YES completion:^{
  }];
  WebViewController* webVC = (WebViewController*)tabModel.ID;
  self.browserVC.webVC = webVC;
}

- (void)tabSwitcherDidTapDoneButton:(id)tabSwitcher {
  [self dismissViewControllerAnimated:YES completion:^{
  }];
}

- (void)tabSwitcher:(TabSwitcherViewController *)tabSwitcher didTapNewTabButtonInIncognitoMode:(BOOL)inIncognitoMode {
  [self addAndShowWebVC:[self createNtp]];
  [self dismissViewControllerAnimated:YES completion:^{
  }];
}

#pragma mark - BrowserDelegate

- (void)browserDidTapTabSwitcherButton:(BrowserViewController *)browser {
  WKWebView* webView = self.browserVC.webVC.webView;
  WKSnapshotConfiguration* conf = [WKSnapshotConfiguration new];
  __weak ViewController* weakSelf = self;
  [webView takeSnapshotWithConfiguration:conf completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
    if (error) {
      NSLog(@"WKWebView takeSnapshot failed: %@", error);
      return;
    }
    [weakSelf.tabSwitcherVC updateTabModel:[TabModel modelWithID:weakSelf.browserVC.webVC title:nil screenShot:snapshotImage]];
  }];
  [self presentViewController:_tabSwitcherVC animated:YES completion:^{
  }];
}

#pragma mark - WebDelegate

- (void)webViewController:(WebViewController*)oldWebVC didCreateWebViewController:(WebViewController*)newWebVC {
  [self addAndShowWebVC:newWebVC];
}

- (void)webViewController:(WebViewController *)webVC didChangeTitle:(NSString *)title {
  [self.tabSwitcherVC updateTabModel:[TabModel modelWithID:webVC title:title screenShot:nil]];
}

#pragma mark - Helper methods

- (WebViewController*)createNtp {
  WebViewController* ntp = [WebViewController new];
  [ntp.webView loadHTMLString:@"<html><head><title>NTP</title></head><body><h1>NTP</h1></body></html>" baseURL:[NSURL URLWithString:@"http://ntp.com"]];
  return ntp;
}

- (void)addAndShowWebVC:(WebViewController*)webVC {
  [self.webVCs addObject:webVC];
  [webVC addObserver:self];
  [self.tabSwitcherVC addTabModel:[TabModel modelWithID:webVC title:webVC.title screenShot:nil]];
  self.browserVC.webVC = webVC;
}

@end
