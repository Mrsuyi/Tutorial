//
//  WebViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebViewController.h"
#import "../base/Observers.h"

@interface WebViewController ()<WKUIDelegate, WKNavigationDelegate>
@end

@implementation WebViewController {
  Observers<id<WebObserver>>* _observers;
}

- (instancetype)init {
  return [self initWithWKWebViewConfiguration:[WKWebViewConfiguration new]];
}

- (instancetype)initWithWKWebViewConfiguration:(WKWebViewConfiguration*)configuration {
  self = [super init];
  if (self) {
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;

    _observers = [Observers new];
  }
  return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Layout self.view.
  self.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.webView];
  [NSLayoutConstraint activateConstraints:@[
                                            [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                            [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                            [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            ]];
}

#pragma mark - WKUIDelegate

- (WKWebView*)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
  forNavigationAction:(WKNavigationAction *)navigationAction
       windowFeatures:(WKWindowFeatures *)windowFeatures {
  WebViewController* newWebVC = [[WebViewController alloc] initWithWKWebViewConfiguration:configuration];
  [_observers notify:@selector(webViewController:didCreateWebViewController:) withObject:newWebVC];
  return newWebVC.webView;
}

- (void)webView:(WKWebView *)webView
runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(void))completionHandler {
  completionHandler();
}

- (void)webView:(WKWebView *)webView
runJavaScriptConfirmPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(BOOL))completionHandler {
  completionHandler(NO);
}

- (void)webView:(WKWebView *)webView
runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
    defaultText:(NSString *)defaultText
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(NSString * _Nullable))completionHandler {
  completionHandler(@"shit");
}

- (void)webViewDidClose:(WKWebView *)webView {
  
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
  return NO;
}

- (UIViewController*)webView:(WKWebView *)webView
previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo
              defaultActions:(NSArray<id<WKPreviewActionItem>> *)previewActions {
  return nil;
}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
  
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
  NSLog(@"webView:didCommitNavigation:");
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
  NSLog(@"webView:didStartProvisionalNavigation:");
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
  NSLog(@"webView:didReceiveServerRedirectForProvisioinalNavigation:");
}

- (void)webView:(WKWebView *)webView
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
  NSLog(@"webView:didReceiveAuthenticationChanllenge:completionHandler:");
  completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)webView:(WKWebView *)webView
didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
  NSLog(@"webView:didFailNavigation:withError:");
}

- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
  NSLog(@"webView:didFailProvisionalNavigation:withError:");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
  NSLog(@"webView:didFinishNavigation:");
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
  NSLog(@"webViewWebContentProcessDidTerminate:");
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  NSLog(@"webView:decidePolicyForNavigationAction:decisionHandler:");
  decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
  NSLog(@"webView:decidePolicyForNavigationResponse:decisionHandler:");
  decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - Public methods

- (void)addObserver:(id<WebObserver>)delegate {
  [_observers addObserver:delegate];
}

@end
