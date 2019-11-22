//
//  NavigationHandler.m
//  wkwebview
//
//  Created by Yi Su on 7/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "NavigationHandler.h"
#import "../../base/Utils.h"
#import "ErrorPage.h"

@implementation NavigationHandler

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView*)webView
    decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction
                    decisionHandler:
                        (void (^)(WKNavigationActionPolicy))decisionHandler {
  NSLog(@"Nav-action %@", navigationAction);
  Log(webView);
  decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView*)webView
    decidePolicyForNavigationResponse:(WKNavigationResponse*)navigationResponse
                      decisionHandler:(void (^)(WKNavigationResponsePolicy))
                                          decisionHandler {
  NSLog(@"Nav-response: URL: %@ main-frame %ul MIME: %@",
        navigationResponse.response.URL, navigationResponse.isForMainFrame,
        navigationResponse.response.MIMEType);
  Log(webView);
  decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView*)webView
    didStartProvisionalNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-start-provision: %@", navigation);
  Log(webView);
}

- (void)webView:(WKWebView*)webView
    didFailProvisionalNavigation:(WKNavigation*)navigation
                       withError:(NSError*)error {
  NSLog(@"Nav-fail-provision: %@ error: %@", navigation, error);
  Log(webView);

  ErrorPage* errorPage = [[ErrorPage alloc] initWithError:error];
  WKBackForwardListItem* item = webView.backForwardList.currentItem;
  // There are 3 possible scenarios here:
  //   1. Current nav item is an error page for failed URL;
  //   2. Current nav item has a failed URL. This may happen when
  //      back/forward/refresh on a loaded page;
  //   3. Current nav item is an irrelevant page.
  // For 1&2, load error page HTML into current page;
  // For 3, load error page file to create a new nav item.
  if ([errorPage matchURL:item.URL] || [item.URL isEqual:errorPage.failedURL]) {
    [webView evaluateJavaScript:errorPage.injectScript
              completionHandler:^(id result, NSError* error) {
                NSLog(@"inject error page failed: %@", error);
              }];
    //    [webView loadHTMLString:errorPage.injectHTML
    //    baseURL:errorPage.failedURL];
  } else {
    [webView loadFileURL:errorPage.fileURL
        allowingReadAccessToURL:errorPage.fileURL];
  }
}

- (void)webView:(WKWebView*)webView
    didReceiveServerRedirectForProvisionalNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-redir: %@", navigation);
  Log(webView);
}

- (void)webView:(WKWebView*)webView
    didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge*)challenge
                    completionHandler:
                        (void (^)(NSURLSessionAuthChallengeDisposition,
                                  NSURLCredential* _Nullable))
                            completionHandler {
  NSLog(@"Nav-auth: %@://%@:%ld", challenge.protectionSpace.protocol,
        challenge.protectionSpace.host, challenge.protectionSpace.port);
  Log(webView);
  completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)webView:(WKWebView*)webView
    didCommitNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-commit: %@", navigation);
  Log(webView);
}

- (void)webView:(WKWebView*)webView
    didFinishNavigation:(WKNavigation*)navigation {
  NSLog(@"Nav-finish: %@", navigation);
  [self.delegate navigationHandler:self didFinishNavigationWithError:nil];
  Log(webView);
}

- (void)webView:(WKWebView*)webView
    didFailNavigation:(WKNavigation*)navigation
            withError:(NSError*)error {
  NSLog(@"Nav-fail: %@ error: %@", navigation, error);
  Log(webView);
  ErrorPage* errorPage = [[ErrorPage alloc] initWithError:error];
  //  [webView evaluateJavaScript:errorPage.injectScript
  //            completionHandler:^(id result, NSError* error) {
  //              NSLog(@"inject error page failed: %@", error);
  //            }];
  [webView loadHTMLString:errorPage.injectHTML baseURL:errorPage.failedURL];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView*)webView {
  NSLog(@"Nav-terminate");
  Log(webView);
}

@end
