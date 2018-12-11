//
//  BarButtonItem.h
//  uikit
//
//  Created by Yi Su on 12/12/18.
//  Copyright © 2018 google. All rights reserved.
//

#ifndef BarButtonItem_h
#define BarButtonItem_h

#import <UIKit/UIKit.h>

@interface LeftBarButton : UIBarButtonItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

@interface RightBarButton : UIBarButtonItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

#endif /* BarButtonItem_h */
