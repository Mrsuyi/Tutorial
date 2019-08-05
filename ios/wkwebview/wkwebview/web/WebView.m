//
//  WebView.m
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebView.h"
#import "../base/LayoutUtils.h"
#import "../base/Observers.h"
#import "WebViewConfiguration.h"
#import "WebsiteDataStore.h"
#import "navigation/WKNavigationHandler.h"

@interface WebView () <WKUIDelegate>

@property(nonatomic, readwrite) BOOL incognito;
@property(nonatomic, readonly, strong) WKNavigationHandler* navigationHandler;

@end

@implementation WebView {
  Observers<id<WebObserver>>* _observers;
}

- (instancetype)initInIncognitoMode:(BOOL)incognito {
  WKWebViewConfiguration* conf = incognito
                                     ? GetIncognitoWKWebViewConfiguration()
                                     : GetRegularWKWebViewConfiguration();
  self = [self initWithWKWebViewConfiguration:conf];
  if (self) {
    _incognito = incognito;
  }
  return self;
}

- (instancetype)initWithWKWebViewConfiguration:
    (WKWebViewConfiguration*)configuration {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _WKWebView = [[WKWebView alloc] initWithFrame:CGRectZero
                                    configuration:configuration];
    _WKWebView.UIDelegate = self;

    _observers = [Observers new];
    _navigationHandler = [[WKNavigationHandler alloc] init];
    _WKWebView.navigationDelegate = _navigationHandler;

    for (NSString* key in [self WKWebViewKVOKeyPaths]) {
      [_WKWebView addObserver:self forKeyPath:key options:0 context:nil];
    }

    _WKWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_WKWebView];
    [NSLayoutConstraint
        activateConstraints:CreateSameSizeConstraints(self, _WKWebView)];
  }
  return self;
}

#pragma mark - WKUIDelegate

- (WKWebView*)webView:(WKWebView*)webView
    createWebViewWithConfiguration:(WKWebViewConfiguration*)configuration
               forNavigationAction:(WKNavigationAction*)navigationAction
                    windowFeatures:(WKWindowFeatures*)windowFeatures {
  WebView* newWebVC =
      [[WebView alloc] initWithWKWebViewConfiguration:configuration];
  newWebVC.incognito = _incognito;
  [_observers notify:@selector(WebView:didCreateWebView:) withObject:newWebVC];
  return newWebVC.WKWebView;
}

- (void)webView:(WKWebView*)webView
    runJavaScriptAlertPanelWithMessage:(NSString*)message
                      initiatedByFrame:(WKFrameInfo*)frame
                     completionHandler:(void (^)(void))completionHandler {
  UIAlertController* alert =
      [UIAlertController alertControllerWithTitle:@"Alert from page"
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* ok =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction* _Nonnull action) {
                               completionHandler();
                             }];
  [alert addAction:ok];
  //  [self presentViewController:alert
  //                     animated:YES
  //                   completion:^{
  //                   }];
}

- (void)webView:(WKWebView*)webView
    runJavaScriptConfirmPanelWithMessage:(NSString*)message
                        initiatedByFrame:(WKFrameInfo*)frame
                       completionHandler:(void (^)(BOOL))completionHandler {
  UIAlertController* alert =
      [UIAlertController alertControllerWithTitle:@"Confirm from page"
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* ok =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction* _Nonnull action) {
                               completionHandler(YES);
                             }];
  UIAlertAction* cancel =
      [UIAlertAction actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction* _Nonnull action) {
                               completionHandler(NO);
                             }];
  [alert addAction:ok];
  [alert addAction:cancel];
  //  [self presentViewController:alert
  //                     animated:YES
  //                   completion:^{
  //                   }];
}

- (void)webView:(WKWebView*)webView
    runJavaScriptTextInputPanelWithPrompt:(NSString*)prompt
                              defaultText:(NSString*)defaultText
                         initiatedByFrame:(WKFrameInfo*)frame
                        completionHandler:
                            (void (^)(NSString* _Nullable))completionHandler {
  UIAlertController* alert =
      [UIAlertController alertControllerWithTitle:@"Prompt from page"
                                          message:prompt
                                   preferredStyle:UIAlertControllerStyleAlert];
  [alert
      addTextFieldWithConfigurationHandler:^(UITextField* _Nonnull textField) {
        textField.text = defaultText;
      }];
  __weak UIAlertController* weakAlert = alert;
  UIAlertAction* ok =
      [UIAlertAction actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction* _Nonnull action) {
                               completionHandler(weakAlert.textFields[0].text);
                             }];
  [alert addAction:ok];
  //  [self presentViewController:alert
  //                     animated:YES
  //                   completion:^{
  //                   }];
}

- (void)webViewDidClose:(WKWebView*)webView {
}

- (BOOL)webView:(WKWebView*)webView
    shouldPreviewElement:(WKPreviewElementInfo*)elementInfo {
  return NO;
}

- (UIViewController*)webView:(WKWebView*)webView
    previewingViewControllerForElement:(WKPreviewElementInfo*)elementInfo
                        defaultActions:
                            (NSArray<id<WKPreviewActionItem>>*)previewActions {
  return nil;
}

- (void)webView:(WKWebView*)webView
    commitPreviewingViewController:(UIViewController*)previewingViewController {
}

#pragma mark - NSObject

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id>*)change
                       context:(void*)context {
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
  [self.WKWebView loadHTMLString:@"<html><head><title>NTP</title></"
                                 @"head><body><h1>NTP</h1></body></html>"
                         baseURL:[NSURL URLWithString:@"http://ntp.com"]];
}

#pragma mark - Private methods

- (NSDictionary<NSString*, NSString*>*)WKWebViewKVOKeyPaths {
  return @{
    @"title" : @"WebViewDidChangeTitle:",
    @"URL" : @"WebViewDidChangeURL:",
    @"estimatedProgress" : @"WebViewDidChangeEstimatedProgress",
    @"canGoBack" : @"WebViewDidChangeCanGoBack:",
    @"canGoForward" : @"WebViewDidChangeCanGoForward:"
  };
}

@end
