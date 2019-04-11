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
- (void)webViewController:(WebViewController*)WebVC didCreateWebViewController:(WebViewController*)newWebVC;
- (void)webViewController:(WebViewController*)webVC didChangeURL:(NSURL*)URL;

@end

@interface WebViewController : UIViewController

- (instancetype)init;
- (instancetype)initWithWKWebViewConfiguration:(WKWebViewConfiguration*)configuration;

@property(nonatomic, strong)WKWebView* webView;

- (void)addObserver:(id<WebObserver>)delegate;

@end


#endif /* WebViewController_h */
