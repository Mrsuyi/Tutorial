//
//  UIHandler.m
//  wkwebview
//
//  Created by Yi Su on 8/5/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "UIHandler.h"

@implementation UIHandler

#pragma mark - WKUIDelegate

- (WKWebView*)webView:(WKWebView*)webView
    createWebViewWithConfiguration:(WKWebViewConfiguration*)configuration
               forNavigationAction:(WKNavigationAction*)navigationAction
                    windowFeatures:(WKWindowFeatures*)windowFeatures {
  return [self.delegate webView:webView
      createWebViewWithConfiguration:configuration
                 forNavigationAction:navigationAction
                      windowFeatures:windowFeatures];
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
  [self.delegate webViewDidClose:webView];
}

@end
