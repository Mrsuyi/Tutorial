//
//  ViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/8/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "ViewController.h"
#import "web/WebViewController.h"
#import "tab_switcher/TabSwitcherViewController.h"

@interface ViewController ()<UITextFieldDelegate, UIToolbarDelegate, TabSwitcherDelegate>

@property(nonatomic, readonly)WebViewController* currentWebVC;

@end

@implementation ViewController {
  NSMutableDictionary<NSNumber*, WebViewController*>* _webVCs;
  NSMutableDictionary<NSNumber*, NSArray<NSLayoutConstraint*>*>* _webVCConstraints;
  NSInteger _currentWebVCID;
  NSInteger _webVCIDcounter;

  TabSwitcherViewController* _tabSwitcherVC;

  // UI
  UITextField* _omnibox;

  UIView* _webViewContainer;

  UIBarButtonItem* _backBtn;
  UIBarButtonItem* _forwardBtn;
  UIBarButtonItem* _refreshBtn;
  UIBarButtonItem* _tabSwitcherBtn;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _webVCs = [NSMutableDictionary new];
    _webVCConstraints = [NSMutableDictionary new];
    _tabSwitcherVC = [TabSwitcherViewController new];
    _tabSwitcherVC.delegate = self;
    _webVCIDcounter = 0;
    _currentWebVCID = -1;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  // Init top toolbar.
  _omnibox = [UITextField new];
  _omnibox.translatesAutoresizingMaskIntoConstraints = NO;
  _omnibox.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  _omnibox.borderStyle = UITextBorderStyleRoundedRect;
  _omnibox.text = @"https://www.google.com";
  _omnibox.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _omnibox.delegate = self;
  UIBarButtonItem* omniboxItem = [[UIBarButtonItem alloc] initWithCustomView:_omnibox];

  UIToolbar* topToolbar = [UIToolbar new];
  topToolbar.translatesAutoresizingMaskIntoConstraints = NO;
  topToolbar.barTintColor = UIColor.whiteColor;
  topToolbar.translucent = YES;
  [topToolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
  topToolbar.delegate = self;
  [topToolbar setItems:@[omniboxItem]];

  // Init WebViewContainer.
  _webViewContainer = [UIView new];
  _webViewContainer.translatesAutoresizingMaskIntoConstraints = NO;

  // Init bottom toolbar.
  _backBtn = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBackBtn)];
  _forwardBtn = [[UIBarButtonItem alloc] initWithTitle:@"→" style:UIBarButtonItemStylePlain target:self action:@selector(onTapForwardBtn)];
  _refreshBtn = [[UIBarButtonItem alloc] initWithTitle:@"⟲" style:UIBarButtonItemStylePlain target:self action:@selector(onTapRefreshBtn)];
  _tabSwitcherBtn = [[UIBarButtonItem alloc] initWithTitle:@"∑" style:UIBarButtonItemStylePlain target:self action:@selector(onTapTabSwitcherBtn)];
  UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

  UIToolbar* bottomToolbar = [UIToolbar new];
  bottomToolbar.translatesAutoresizingMaskIntoConstraints = NO;
  bottomToolbar.barTintColor = UIColor.whiteColor;
  bottomToolbar.translucent = YES;
  [bottomToolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
  [bottomToolbar setItems:@[_backBtn, space, _forwardBtn, space, _refreshBtn, space, _tabSwitcherBtn]];

  // Layout self.view.
  [self.view addSubview:topToolbar];
  [self.view addSubview:_webViewContainer];
  [self.view addSubview:bottomToolbar];
  [NSLayoutConstraint activateConstraints:@[[topToolbar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                            [topToolbar.bottomAnchor constraintEqualToAnchor:_webViewContainer.topAnchor],
                                            [topToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [topToolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            //
                                            [_webViewContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [_webViewContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            [_webViewContainer.bottomAnchor constraintEqualToAnchor:bottomToolbar.topAnchor],
                                            //
                                            [bottomToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [bottomToolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            [bottomToolbar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                            ]];

  // Init and display first WebVC.
  [self addNtp];
}

#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  return UIBarPositionTopAttached;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_omnibox.text]];
  [self.currentWebVC.webView loadRequest:request];
  return YES;
}

#pragma mark - TabSwitcherDelegate

- (void)didSelectTab:(TabModel *)tabModel {
  [self dismissViewControllerAnimated:YES completion:^{
  }];
  [self displayWebVCwithID:tabModel.ID];
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

#pragma mark - Button callbacks

- (void)onTapBackBtn {
  
}

- (void)onTapForwardBtn {
  
}

- (void)onTapRefreshBtn {
  [self.currentWebVC.webView reload];
}

- (void)onTapTabSwitcherBtn {
  [self presentViewController:_tabSwitcherVC animated:YES completion:^{
  }];
}

#pragma mark - Helper methods

- (void)addNtp {
  NSInteger webVCID = _webVCIDcounter++;
  _webVCs[[NSNumber numberWithInteger:webVCID]] = [WebViewController new];
  [self displayWebVCwithID:webVCID];
  [self.currentWebVC.webView loadHTMLString:@"<html><body><h1>NTP</h1></body></html>" baseURL:[NSURL URLWithString:@"http://ntp.com"]];

  [_tabSwitcherVC addTabModel:[TabModel modelWithID:webVCID title:@"http://ntp.com" screenShot:nil]];
}

- (WebViewController*)currentWebVC {
  return _webVCs[[NSNumber numberWithInteger:_currentWebVCID]];
}

- (void)displayWebVCwithID:(NSInteger)ID {
  if (ID == _currentWebVCID)
    return;

  NSNumber* key;

  // Remove currently displayed WebView.
  if (_currentWebVCID != -1) {
    [NSNumber numberWithInteger:_currentWebVCID];
    [NSLayoutConstraint deactivateConstraints:_webVCConstraints[key]];
    [_webVCs[key] removeFromParentViewController];
    [_webVCs[key].view removeFromSuperview];
  }

  _currentWebVCID = ID;
  key = [NSNumber numberWithInteger:ID];
  WebViewController* webVC = _webVCs[key];
  [self addChildViewController:webVC];
  [_webViewContainer addSubview:webVC.view];
  if (![_webVCConstraints objectForKey:key]) {
    _webVCConstraints[key] = @[[webVC.view.topAnchor constraintEqualToAnchor:_webViewContainer.topAnchor],
                               [webVC.view.bottomAnchor constraintEqualToAnchor:_webViewContainer.bottomAnchor],
                               [webVC.view.leadingAnchor constraintEqualToAnchor:_webViewContainer.leadingAnchor],
                               [webVC.view.trailingAnchor constraintEqualToAnchor:_webViewContainer.trailingAnchor]];
  }
  [NSLayoutConstraint activateConstraints:_webVCConstraints[key]];
}

@end
