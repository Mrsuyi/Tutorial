//
//  BrowserViewController.h
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef BrowserViewController_h
#define BrowserViewController_h

#import <UIKit/UIKit.h>
#import "../WebViewList.h"
#import "../web/WebView.h"

@class BrowserViewController;

@protocol BrowserDelegate

- (void)browserDidTapTabSwitcherButton:(BrowserViewController*)browser;

@end

@interface BrowserViewController : UIViewController <WebViewListObserver>

@property(nonatomic, weak) id<BrowserDelegate> delegate;
@property(nonatomic, weak, readonly) WebView* webView;

@end

#endif /* BrowserViewController_h */
