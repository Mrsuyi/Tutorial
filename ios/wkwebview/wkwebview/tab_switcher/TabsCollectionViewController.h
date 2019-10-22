//
//  TabsCollectionViewController.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef TabsCollectionViewController_h
#define TabsCollectionViewController_h

#import <UIKit/UIKit.h>
#import "../WebViewList.h"
#import "TabModel.h"

@class TabsCollectionViewController;

@protocol TabsCollectionDelegate

- (void)tabsCollection:(TabsCollectionViewController*)tabsCollectionVC
      didSelectWebView:(WebView*)webView;

@end

@interface TabsCollectionViewController : UICollectionViewController

@property(nonatomic, weak) id<TabsCollectionDelegate> delegate;
@property(nonatomic, weak) WebViewList* webViewList;

- (void)updateWebViewScreenShot:(WebView*)webView;

@end

#endif /* TabsCollectionViewController_h */
