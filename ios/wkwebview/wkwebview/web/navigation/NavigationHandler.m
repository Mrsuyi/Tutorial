//
//  NavigationHandler.m
//  wkwebview
//
//  Created by Yi Su on 7/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "NavigationHandler.h"

#define LOG                                                           \
  NSLog(@"URL: %@ loading: %d cur-URL: %@ init-URL: %@", webView.URL, \
        webView.loading, webView.backForwardList.currentItem.URL,     \
        webView.backForwardList.currentItem.initialURL)

@implementation NavigationHandler

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView*)webView
    decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction
                    decisionHandler:
                        (void (^)(WKNavigationActionPolicy))decisionHandler {
  NSLog(@"Nav-action %@", navigationAction);
  LOG;
  decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView*)webView
    decidePolicyForNavigationResponse:(WKNavigationResponse*)navigationResponse
                      decisionHandler:(void (^)(WKNavigationResponsePolicy))
                                          decisionHandler {
  NSLog(@"Nav-response: URL: %@ main-frame %ul MIME: %@",
        navigationResponse.response.URL, navigationResponse.isForMainFrame,
        navigationResponse.response.MIMEType);
  LOG;
  decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView*)webView
    didStartProvisionalNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-start-provision: %@", navigation);
  LOG;
}

- (void)webView:(WKWebView*)webView
    didFailProvisionalNavigation:(WKNavigation*)navigation
                       withError:(NSError*)error {
  NSLog(@"Nav-fail-provision: %@ error: %@", navigation, error);
  LOG;

  NSString* originalURL = error.userInfo[NSURLErrorFailingURLStringErrorKey];
  NSString* encodedOriginalURL =
      [originalURL stringByAddingPercentEncodingWithAllowedCharacters:
                       NSCharacterSet.URLQueryAllowedCharacterSet];
  NSString* path =
      [NSBundle.mainBundle pathForResource:@"error_page_placeholder"
                                    ofType:@"html"];
  NSString* pathURL =
      [NSString stringWithFormat:@"file://%@#%@", path, encodedOriginalURL];
  NSURL* errorPageURL = [NSURL URLWithString:pathURL];

  // If current navigation item is an error page for the same |failedURL|,
  // inject the error message into the page; otherwise load a new error page.
  WKBackForwardListItem* item = webView.backForwardList.currentItem;
  // There are 3 possible scenarios here:
  //   1. Current nav item is the error page for |originalURL|;
  //   2. Current nav item has original URL, which means this failure happens
  //   during a back/forward/refresh on a page that loaded successfully before;
  //   3. Current nav item is an irrelevant page.
  // For 1&2, inject error page HTML into current page;
  // For 3, load "loaded_error_page.html" to create a nav item for error page.
  if ([item.URL isEqual:errorPageURL] ||
      [item.URL isEqual:[NSURL URLWithString:originalURL]]) {
    NSString* path = [NSBundle.mainBundle pathForResource:@"error_page_content"
                                                   ofType:@"html"];
    NSString* template = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    NSString* html =
        [NSString stringWithFormat:template, error.localizedDescription];
    [webView loadHTMLString:html baseURL:[NSURL URLWithString:originalURL]];
  } else {
    [webView loadFileURL:errorPageURL allowingReadAccessToURL:errorPageURL];
  }
}

- (void)webView:(WKWebView*)webView
    didReceiveServerRedirectForProvisionalNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-redir: %@", navigation);
  LOG;
}

- (void)webView:(WKWebView*)webView
    didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge
                    completionHandler:
                        (void (^)(NSURLSessionAuthChallengeDisposition,
                                  NSURLCredential* _Nullable))
                            completionHandler {
  NSLog(@"Nav-auth: %@://%@:%ld", challenge.protectionSpace.protocol,
        challenge.protectionSpace.host, challenge.protectionSpace.port);
  LOG;
  completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)webView:(WKWebView*)webView
    didCommitNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-commit: %@", navigation);
  LOG;
}

- (void)webView:(WKWebView*)webView
    didFinishNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-finish: %@", navigation);
  LOG;
}

- (void)webView:(WKWebView*)webView
    didFailNavigation:(WKNavigation*)navigation
            withError:(NSError*)error {
  NSLog(@"Nav-fail: %@ error: %@", navigation, error);
  LOG;

  NSString* originalURL = error.userInfo[NSURLErrorFailingURLStringErrorKey];
  NSString* path = [NSBundle.mainBundle pathForResource:@"error_page_content"
                                                 ofType:@"html"];
  NSString* template = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
  NSString* html =
      [NSString stringWithFormat:template, error.localizedDescription];
  [webView loadHTMLString:html baseURL:[NSURL URLWithString:originalURL]];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView*)webView {
  NSLog(@"Nav-terminate");
  LOG;
}

@end
