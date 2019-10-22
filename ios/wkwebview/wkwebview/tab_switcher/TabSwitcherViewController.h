//
//  TabSwitcherViewController.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef TabSwitcherViewController_h
#define TabSwitcherViewController_h

#import <UIKit/UIKit.h>
#import "../WebViewList.h"
#import "TabModel.h"

@class TabSwitcherViewController;

@protocol TabSwitcherDelegate

- (void)tabSwitcher:(TabSwitcherViewController*)tabSwitcher
    didSelectWebView:(WebView*)webView;
- (void)tabSwitcher:(TabSwitcherViewController*)tabSwitcher
    didTapNewTabButtonInIncognitoMode:(BOOL)inIncognitoMode;
- (void)tabSwitcherDidTapDoneButton:(TabSwitcherViewController*)tabSwitcher;

@end

@interface TabSwitcherViewController : UIViewController <WebViewListObserver>

@property(nonatomic, weak) id<TabSwitcherDelegate> delegate;

- (void)updateWebViewScreenShot:(WebView*)webView;

@end

#endif /* TabSwitcherViewController_h */
