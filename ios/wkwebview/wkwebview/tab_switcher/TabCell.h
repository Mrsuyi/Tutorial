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

@interface TabCell : UICollectionViewCell

@property(nonatomic, copy)UILabel* titleLabel;
@property(nonatomic, strong)UIImageView* screenShotView;

@end

#endif /* TabCell_h */
