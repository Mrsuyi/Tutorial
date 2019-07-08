//
//  WebViewController.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WebViewController_h
#define WebViewController_h

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class WebViewController;

@protocol WebObserver <NSObject>

@optional
- (void)webViewController:(WebViewController*)WebVC
    didCreateWebViewController:(WebViewController*)newWebVC;
- (void)webViewControllerDidChangeURL:(WebViewController*)webVC;
- (void)webViewControllerDidChangeTitle:(WebViewController*)webVC;
- (void)webViewControllerDidChangeEstimatedProgress:(WebViewController*)webVC;
- (void)webViewControllerDidChangeCanGoBack:(WebViewController*)webVC;
- (void)webViewControllerDidChangeCanGoForward:(WebViewController*)webVC;

@end

@interface WebViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initInIncognitoMode:(BOOL)incognito;

@property(nonatomic, readonly) BOOL incognito;
@property(nonatomic, strong) WKWebView* webView;

- (void)loadNTP;
- (void)addObserver:(id<WebObserver>)delegate;
- (void)removeObserver:(id<WebObserver>)delegate;

@end

#endif /* WebViewController_h */
