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
#import "TabModel.h"

@protocol TabSwitcherDelegate

- (void)didSelectTab:(TabModel*)tabModel;
- (void)didTapNewTabButton;
- (void)didTapDoneButton;

@end

@interface TabSwitcherViewController : UIViewController

@property(nonatomic, weak)id<TabSwitcherDelegate> delegate;

- (void)addTabModel:(TabModel*)tabModel;
- (void)updateTabModel:(TabModel*)tabModel;

@end

#endif /* TabSwitcherViewController_h */
