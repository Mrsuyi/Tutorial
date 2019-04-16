//
//  BrowserViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "BrowserViewController.h"
#import "../base/LayoutUtils.h"

@interface BrowserViewController ()<UIToolbarDelegate, UITextFieldDelegate, WebObserver>

@end

@implementation BrowserViewController {
  UIToolbar* _topToolbar;
  UITextField* _omnibox;

  UIView* _webViewContainer;
  NSArray* _webViewConstraints;

  UIToolbar* _bottomToolbar;
  UIBarButtonItem* _backBtn;
  UIBarButtonItem* _forwardBtn;
  UIBarButtonItem* _refreshBtn;
  UIBarButtonItem* _tabSwitcherBtn;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Init top toolbar.
  _omnibox = [UITextField new];
  _omnibox.translatesAutoresizingMaskIntoConstraints = NO;
  _omnibox.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  _omnibox.borderStyle = UITextBorderStyleRoundedRect;
  _omnibox.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _omnibox.delegate = self;
  _omnibox.autocorrectionType = UITextAutocorrectionTypeNo;
  UIBarButtonItem* omniboxItem = [[UIBarButtonItem alloc] initWithCustomView:_omnibox];

  _topToolbar = [UIToolbar new];
  _topToolbar.translatesAutoresizingMaskIntoConstraints = NO;
  _topToolbar.translucent = YES;
  [_topToolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
  _topToolbar.delegate = self;
  [_topToolbar setItems:@[omniboxItem]];

  // Init WebViewContainer.
  _webViewContainer = [UIView new];
  _webViewContainer.translatesAutoresizingMaskIntoConstraints = NO;

  // Init bottom toolbar.
  _backBtn = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBackBtn)];
  _forwardBtn = [[UIBarButtonItem alloc] initWithTitle:@"→" style:UIBarButtonItemStylePlain target:self action:@selector(onTapForwardBtn)];
  _refreshBtn = [[UIBarButtonItem alloc] initWithTitle:@"⟲" style:UIBarButtonItemStylePlain target:self action:@selector(onTapRefreshBtn)];
  _tabSwitcherBtn = [[UIBarButtonItem alloc] initWithTitle:@"∑" style:UIBarButtonItemStylePlain target:self action:@selector(onTapTabSwitcherBtn)];
  UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  
  _bottomToolbar = [UIToolbar new];
  _bottomToolbar.translatesAutoresizingMaskIntoConstraints = NO;
  _bottomToolbar.translucent = YES;
  [_bottomToolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
  [_bottomToolbar setItems:@[_backBtn, space, _forwardBtn, space, _refreshBtn, space, _tabSwitcherBtn]];

  // Layout self.view.
  [self.view addSubview:_topToolbar];
  [self.view addSubview:_webViewContainer];
  [self.view addSubview:_bottomToolbar];
  [NSLayoutConstraint activateConstraints:@[[_topToolbar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                            [_topToolbar.bottomAnchor constraintEqualToAnchor:_webViewContainer.topAnchor],
                                            [_topToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [_topToolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            //
                                            [_webViewContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [_webViewContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            [_webViewContainer.bottomAnchor constraintEqualToAnchor:_bottomToolbar.topAnchor],
                                            //
                                            [_bottomToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [_bottomToolbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            [_bottomToolbar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                            ]];
}

- (void)viewWillAppear:(BOOL)animated {
  
}

- (void)viewWillDisappear:(BOOL)animated {
  
}

#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  return UIBarPositionTopAttached;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_omnibox.text]];
  [self.webVC.webView loadRequest:request];
  return YES;
}

#pragma mark - WebObserver

- (void)webViewControllerDidChangeTitle:(WebViewController *)webVC {
  
}

- (void)webViewControllerDidChangeURL:(WebViewController *)webVC {
  _omnibox.text = webVC.webView.URL.absoluteString;
}

- (void)webViewControllerDidChangeEstimatedProgress:(WebViewController *)webVC {
  
}

- (void)webViewControllerDidChangeCanGoBack:(WebViewController *)webVC {
  _backBtn.enabled = webVC.webView.canGoBack;
}

- (void)webViewControllerDidChangeCanGoForward:(WebViewController *)webVC {
  _forwardBtn.enabled = webVC.webView.canGoForward;
}

#pragma mark - Property accessors

- (void)setWebVC:(WebViewController *)webVC {
  // Remove previous webVC.
  if (_webVC) {
    [_webVC.view removeFromSuperview];
    [_webVC removeFromParentViewController];
    [_webVC removeObserver:self];
    [NSLayoutConstraint deactivateConstraints:_webViewConstraints];
  }
  // Add current webVC.
  _webVC = webVC;
  [self addChildViewController:webVC];
  [webVC addObserver:self];
  [_webViewContainer addSubview:webVC.view];
  _webViewConstraints = CreateSameSizeConstraints(_webViewContainer, webVC.view);
  [NSLayoutConstraint activateConstraints:_webViewConstraints];

  // Update UI.
  if (webVC.incognito) {
    _topToolbar.barTintColor = UIColor.darkGrayColor;
    _topToolbar.tintColor = UIColor.whiteColor;
    _bottomToolbar.barTintColor = UIColor.darkGrayColor;
    _bottomToolbar.tintColor = UIColor.whiteColor;
  } else {
    _topToolbar.barTintColor = UIColor.whiteColor;
    _topToolbar.tintColor = nil;
    _bottomToolbar.barTintColor = UIColor.whiteColor;
    _bottomToolbar.tintColor = nil;
  }
  _backBtn.enabled = webVC.webView.canGoBack;
  _forwardBtn.enabled = webVC.webView.canGoForward;
}

#pragma mark - Button callbacks

- (void)onTapBackBtn {
  [self.webVC.webView goBack];
}

- (void)onTapForwardBtn {
  [self.webVC.webView goForward];
}

- (void)onTapRefreshBtn {
  [self.webVC.webView reload];
}

- (void)onTapTabSwitcherBtn {
  [self.delegate browserDidTapTabSwitcherButton:self];
}

@end
