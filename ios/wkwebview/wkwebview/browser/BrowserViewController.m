//
//  BrowserViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "BrowserViewController.h"
#import "../base/LayoutUtils.h"

@interface BrowserViewController () <UIToolbarDelegate,
                                     UITextFieldDelegate,
                                     WebObserver>

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
  UIBarButtonItem* omniboxItem =
      [[UIBarButtonItem alloc] initWithCustomView:_omnibox];

  _topToolbar = [UIToolbar new];
  _topToolbar.translatesAutoresizingMaskIntoConstraints = NO;
  _topToolbar.translucent = YES;
  [_topToolbar setShadowImage:[UIImage new]
           forToolbarPosition:UIBarPositionAny];
  _topToolbar.delegate = self;
  [_topToolbar setItems:@[ omniboxItem ]];

  // Init WebViewContainer.
  _webViewContainer = [UIView new];
  _webViewContainer.translatesAutoresizingMaskIntoConstraints = NO;

  // Init bottom toolbar.
  _backBtn = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(onTapBackBtn)];
  _forwardBtn =
      [[UIBarButtonItem alloc] initWithTitle:@"→"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(onTapForwardBtn)];
  _refreshBtn =
      [[UIBarButtonItem alloc] initWithTitle:@"⟲"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(onTapRefreshBtn)];
  _tabSwitcherBtn =
      [[UIBarButtonItem alloc] initWithTitle:@"∑"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(onTapTabSwitcherBtn)];
  UIBarButtonItem* space = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                           target:nil
                           action:nil];

  _bottomToolbar = [UIToolbar new];
  _bottomToolbar.translatesAutoresizingMaskIntoConstraints = NO;
  _bottomToolbar.translucent = YES;
  [_bottomToolbar setShadowImage:[UIImage new]
              forToolbarPosition:UIBarPositionAny];
  [_bottomToolbar setItems:@[
    _backBtn, space, _forwardBtn, space, _refreshBtn, space, _tabSwitcherBtn
  ]];

  // Layout self.view.
  [self.view addSubview:_topToolbar];
  [self.view addSubview:_webViewContainer];
  [self.view addSubview:_bottomToolbar];
  [NSLayoutConstraint activateConstraints:@[
    [_topToolbar.topAnchor
        constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
    [_topToolbar.bottomAnchor
        constraintEqualToAnchor:_webViewContainer.topAnchor],
    [_topToolbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [_topToolbar.trailingAnchor
        constraintEqualToAnchor:self.view.trailingAnchor],
    //
    [_webViewContainer.leadingAnchor
        constraintEqualToAnchor:self.view.leadingAnchor],
    [_webViewContainer.trailingAnchor
        constraintEqualToAnchor:self.view.trailingAnchor],
    [_webViewContainer.bottomAnchor
        constraintEqualToAnchor:_bottomToolbar.topAnchor],
    //
    [_bottomToolbar.leadingAnchor
        constraintEqualToAnchor:self.view.leadingAnchor],
    [_bottomToolbar.trailingAnchor
        constraintEqualToAnchor:self.view.trailingAnchor],
    [_bottomToolbar.bottomAnchor
        constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
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

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  [textField resignFirstResponder];
  NSURLRequest* request =
      [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_omnibox.text]];
  [self.webView.WKWebView loadRequest:request];
  return YES;
}

#pragma mark - WebObserver

- (void)WebViewDidChangeTitle:(WebView*)webView {
}

- (void)WebViewDidChangeURL:(WebView*)webView {
  _omnibox.text = webView.WKWebView.URL.absoluteString;
}

- (void)WebViewDidChangeEstimatedProgress:(WebView*)webView {
}

- (void)WebViewDidChangeCanGoBack:(WebView*)webView {
  _backBtn.enabled = webView.WKWebView.canGoBack;
}

- (void)WebViewDidChangeCanGoForward:(WebView*)webView {
  _forwardBtn.enabled = webView.WKWebView.canGoForward;
}

#pragma mark - Property accessors

- (void)setWebView:(WebView*)webView {
  // Remove previous webView.
  if (_webView) {
    [_webView removeFromSuperview];
    [_webView removeObserver:self];
    [NSLayoutConstraint deactivateConstraints:_webViewConstraints];
  }
  // Add current webView.
  _webView = webView;
  webView.translatesAutoresizingMaskIntoConstraints = NO;
  [webView addObserver:self];
  [_webViewContainer addSubview:webView];
  _webViewConstraints = CreateSameSizeConstraints(_webViewContainer, webView);
  [NSLayoutConstraint activateConstraints:_webViewConstraints];

  // Update UI.
  if (webView.incognito) {
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
  _backBtn.enabled = webView.WKWebView.canGoBack;
  _forwardBtn.enabled = webView.WKWebView.canGoForward;
}

#pragma mark - Button callbacks

- (void)onTapBackBtn {
  [self.webView.WKWebView goBack];
}

- (void)onTapForwardBtn {
  [self.webView.WKWebView goForward];
}

- (void)onTapRefreshBtn {
  [self.webView.WKWebView reload];
}

- (void)onTapTabSwitcherBtn {
  [self.delegate browserDidTapTabSwitcherButton:self];
}

@end
