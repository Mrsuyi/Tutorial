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
#import "../web/WebViewController.h"

@protocol BrowserDelegate

- (void)onTapTabSwitcherBtn;

@end

@interface BrowserViewController : UIViewController

@property(nonatomic, weak)id<BrowserDelegate> delegate;
@property(nonatomic, weak)WebViewController* webVC;

@end

#endif /* BrowserViewController_h */
