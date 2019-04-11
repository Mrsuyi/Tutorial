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

@protocol WebViewControllerDelegate

- (void)webViewController:(WebViewController*)oldWebVC didCreateNewWebViewController:(WebViewController*)newWebVC;

@end

@interface WebViewController : UIViewController

@property(nonatomic, strong)WKWebView* webView;
@property(nonatomic, weak)id<WebViewControllerDelegate> delegate;

@end


#endif /* WebViewController_h */
