//
//  WebViewController.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebViewController.h"
#import "../base/Observers.h"
#import "WebsiteDataStore.h"
#import "WebViewConfiguration.h"

@interface WebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property(nonatomic, readwrite)BOOL incognito;

@end

@implementation WebViewController {
  Observers<id<WebObserver>>* _observers;
}

- (instancetype)initInIncognitoMode:(BOOL)incognito {
  WKWebViewConfiguration* conf = incognito ? GetIncognitoWKWebViewConfiguration() : GetRegularWKWebViewConfiguration();
  self = [self initWithWKWebViewConfiguration:conf];
  if (self) {
    _incognito = incognito;
  }
  return self;
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
  [NSLayoutConstraint activateConstraints:@[[self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                            [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                            [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                            [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                            ]];
  
  // Listen to property change on WKWebView.
  for (NSString* key in [self WKWebViewKVOKeyPaths]) {
    [self.webView addObserver:self forKeyPath:key options:0 context:nil];
  }
}

#pragma mark - WKUIDelegate

- (WKWebView*)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
  forNavigationAction:(WKNavigationAction *)navigationAction
       windowFeatures:(WKWindowFeatures *)windowFeatures {
  WebViewController* newWebVC = [[WebViewController alloc] initWithWKWebViewConfiguration:configuration];
  newWebVC.incognito = _incognito;
  [_observers notify:@selector(webViewController:didCreateWebViewController:) withObject:newWebVC];
  return newWebVC.webView;
}

- (void)webView:(WKWebView *)webView
runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(void))completionHandler {
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert from page" message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler();
  }];
  [alert addAction:ok];
  [self presentViewController:alert animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView
runJavaScriptConfirmPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(BOOL))completionHandler {
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirm from page" message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler(YES);
  }];
  UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    completionHandler(NO);
  }];
  [alert addAction:ok];
  [alert addAction:cancel];
  [self presentViewController:alert animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView
runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
    defaultText:(NSString *)defaultText
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(NSString * _Nullable))completionHandler {
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Prompt from page" message:prompt preferredStyle:UIAlertControllerStyleAlert];
  [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.text = defaultText;
  }];
  __weak UIAlertController* weakAlert = alert;
  UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler(weakAlert.textFields[0].text);
  }];
  [alert addAction:ok];
  [self presentViewController:alert animated:YES completion:^{}];
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
  NSLog(@"webView:didFailProvisionalNavigation:withError: %@", error);
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

#pragma mark - NSObject

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  SEL sel = NSSelectorFromString([self WKWebViewKVOKeyPaths][keyPath]);
  [_observers notify:sel withObject:self];
}

#pragma mark - Public methods

- (void)addObserver:(id<WebObserver>)delegate {
  [_observers addObserver:delegate];
}

- (void)removeObserver:(id<WebObserver>)delegate {
  [_observers removeObserver:delegate];
}

- (void)loadNTP {
  [self.webView loadHTMLString:@"<html><head><title>NTP</title></head><body><h1>NTP</h1></body></html>" baseURL:[NSURL URLWithString:@"http://ntp.com"]];
}

#pragma mark - Private methods

- (NSDictionary<NSString*, NSString*>*)WKWebViewKVOKeyPaths {
  return @{@"title" : @"webViewControllerDidChangeTitle:",
           @"URL" : @"webViewControllerDidChangeURL:",
           @"estimatedProgress" : @"webViewControllerDidChangeEstimatedProgress",
           @"canGoBack" : @"webViewControllerDidChangeCanGoBack:",
           @"canGoForward" : @"webViewControllerDidChangeCanGoForward:"};
}

@end
