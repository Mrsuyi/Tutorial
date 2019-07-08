//
//  TabCell.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef TabCell_h
#define TabCell_h

#import <UIKit/UIKit.h>

@class TabCell;

@protocol TabCellDelegate <NSObject>
- (void)tabCellDidTapCloseButton:(TabCell*)tabCell;
@end

@interface TabCell : UICollectionViewCell

@property(nonatomic, assign) BOOL incognito;
@property(nonatomic, copy) UILabel* titleLabel;
@property(nonatomic, strong) UIButton* closeButton;
@property(nonatomic, strong) UIImageView* screenShotView;

@property(nonatomic, weak) id<TabCellDelegate> delegate;

@end

#endif /* TabCell_h */
