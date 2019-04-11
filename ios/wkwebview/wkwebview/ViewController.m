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

@interface ViewController ()<UITextFieldDelegate, UIToolbarDelegate, TabSwitcherDelegate, BrowserDelegate>

@property(nonatomic, readonly)WebViewController* currentWebVC;

@end

@implementation ViewController {
  NSMutableSet<WebViewController*>* _webVCs;

  // UI.
  TabSwitcherViewController* _tabSwitcherVC;
  BrowserViewController* _browserVC;
}

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

  [self.view addSubview:_browserVC.view];

  // Init and display first WebVC.
  [self addNtp];
}

#pragma mark - TabSwitcherDelegate

- (void)didSelectTab:(TabModel *)tabModel {
  [self dismissViewControllerAnimated:YES completion:^{
  }];
  WebViewController* webVC = (WebViewController*)tabModel.ID;
  _browserVC.webVC = webVC;
}

- (void)didTapDoneButton {
  [self dismissViewControllerAnimated:YES completion:^{
  }];
}

- (void)didTapNewTabButton {
  [self addNtp];
  [self dismissViewControllerAnimated:YES completion:^{
  }];
}

#pragma mark - BrowserDelegate

- (void)onTapTabSwitcherBtn {
  [self presentViewController:_tabSwitcherVC animated:YES completion:^{
  }];
}

#pragma mark - Helper methods

- (void)addNtp {
  WebViewController* webVC = [WebViewController new];
  [_webVCs addObject:webVC];

  _browserVC.webVC = webVC;
  [webVC.webView loadHTMLString:@"<html><body><h1>NTP</h1></body></html>" baseURL:[NSURL URLWithString:@"http://ntp.com"]];

  [_tabSwitcherVC addTabModel:[TabModel modelWithID:webVC title:@"http://ntp.com" screenShot:nil]];
}

@end
