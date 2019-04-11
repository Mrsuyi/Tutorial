//
//  BrowserViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()<UIToolbarDelegate, UITextFieldDelegate>

@end

@implementation BrowserViewController {
  UITextField* _omnibox;

  UIView* _webViewContainer;
  NSArray* _webViewConstraints;

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
  _omnibox.text = @"https://www.google.com";
  _omnibox.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _omnibox.delegate = self;
  _omnibox.autocorrectionType = UITextAutocorrectionTypeNo;
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
}

- (void)viewWillAppear:(BOOL)animated {
  
}

- (void)viewWillDisappear:(BOOL)animated {
  
}

#pragma mark - Update WebViewController

- (void)setWebVC:(WebViewController *)webVC {
  if (_webVC) {
    [_webVC.view removeFromSuperview];
    [_webVC removeFromParentViewController];
    [NSLayoutConstraint deactivateConstraints:_webViewConstraints];
  }
  _webVC = webVC;
  [_webViewContainer addSubview:webVC.view];
  _webViewConstraints = @[[webVC.view.topAnchor constraintEqualToAnchor:_webViewContainer.topAnchor],
                          [webVC.view.bottomAnchor constraintEqualToAnchor:_webViewContainer.bottomAnchor],
                          [webVC.view.leadingAnchor constraintEqualToAnchor:_webViewContainer.leadingAnchor],
                          [webVC.view.trailingAnchor constraintEqualToAnchor:_webViewContainer.trailingAnchor],];
  [NSLayoutConstraint activateConstraints:_webViewConstraints];
  [self addChildViewController:webVC];
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
  [self.delegate onTapTabSwitcherBtn];
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

@end
