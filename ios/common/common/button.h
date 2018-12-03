//
//  button.h
//  common
//
//  Created by Yi Su on 03/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#ifndef button_h
#define button_h

#import <UIKit/UIKit.h>

@interface Button : UIButton

@property (nonatomic, strong, readwrite) NSString* title;

- (instancetype)initWithTitle:(NSString*)title frame:(CGRect)frame  NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

#endif /* button_h */
