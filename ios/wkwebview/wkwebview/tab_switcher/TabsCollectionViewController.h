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
#import "TabModel.h"

@class TabsCollectionViewController;

@protocol TabsCollectionDelegate

- (void)tabsCollection:(TabsCollectionViewController*)tabsCollectionVC didSelectTab:(TabModel*)tabModel;
- (void)tabsCollection:(TabsCollectionViewController*)tabsCollectionVC willCloseTab:(TabModel*)tabModel;

@end

@interface TabsCollectionViewController : UICollectionViewController

@property(nonatomic, weak)id<TabsCollectionDelegate> delegate;

- (void)addTabModel:(TabModel*)tabModel;
- (BOOL)hasTabModel:(TabModel*)tabModel;
- (void)updateTabModel:(TabModel*)tabModel;

@end

#endif /* TabsCollectionViewController_h */
