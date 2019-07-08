//
//  ToolbarViewController.m
//  uikit
//
//  Created by Yi Su on 12/20/18.
//  Copyright © 2018 google. All rights reserved.
//

#import "ToolbarViewController.h"

@interface ToolbarViewController () <UIToolbarDelegate>
@end

@implementation ToolbarViewController {
  UIToolbar* _toolbar_top;
  UIToolbar* _toolbar_bottom;
  UIBarButtonItem* _btn_sys_1;
  UIBarButtonItem* _btn_sys_2;
  UIBarButtonItem* _btn_sys_3;

  UIBarButtonItem* _btn_title_1;
  UIBarButtonItem* _btn_title_2;

  UIBarButtonItem* _btn_image;
  UIBarButtonItem* _btn_image_2;

  UIBarButtonItem* _btn_custom;

  UIBarButtonItem* _space;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
  // UIGraphicsBeginImageContext(newSize);
  // In next line, pass 0.0 to use the current device's pixel scaling factor
  // (and thus account for Retina resolution). Pass 1.0 to force exact pixel
  // size.
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.view.backgroundColor = UIColor.whiteColor;

    _btn_sys_1 = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(onShit)];
    [_btn_sys_1 setTitleTextAttributes:@{
      NSForegroundColorAttributeName : UIColor.whiteColor
    }
                              forState:UIControlStateNormal];
    _btn_sys_1.enabled = NO;
    _btn_sys_2 = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                             target:self
                             action:@selector(onShit)];
    _btn_sys_3 = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:self
                             action:@selector(onShit)];

    _btn_title_1 =
        [[UIBarButtonItem alloc] initWithTitle:@"shit"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(onShit)];
    _btn_title_1.title = @"shit";
    _btn_title_1.style = UIBarButtonItemStylePlain;
    _btn_title_1.target = self;
    _btn_title_1.action = @selector(onShit);
    _btn_title_1.enabled = NO;
    _btn_title_2 =
        [[UIBarButtonItem alloc] initWithTitle:@"shit"
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(onShit)];

    UIImage* new_tab = [ToolbarViewController
        imageWithImage:[UIImage imageNamed:@"new_tab.png"]
          scaledToSize:CGSizeMake(32, 32)];
    UIImage* new_tab_incognito = [ToolbarViewController
        imageWithImage:[UIImage imageNamed:@"new_tab_incognito.png"]
          scaledToSize:CGSizeMake(32, 32)];

    _btn_image =
        [[UIBarButtonItem alloc] initWithImage:new_tab_incognito
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(onShit)];

    UIButton* imageButton = [[UIButton alloc] init];
    imageButton.enabled = NO;
    [imageButton setImage:new_tab forState:UIControlStateNormal];
    [imageButton addTarget:self
                    action:@selector(onShit)
          forControlEvents:UIControlEventTouchUpInside];
    imageButton.directionalLayoutMargins =
        NSDirectionalEdgeInsetsMake(-20, -20, -20, -20);

    _btn_custom = [[UIBarButtonItem alloc] init];
    _btn_custom.customView = imageButton;
    _btn_custom.title = @"custom";
    _btn_custom.image = new_tab_incognito;
    //    [_btn_custom setBackgroundVerticalPositionAdjustment:-20
    //    forBarMetrics:UIBarMetricsDefault];

    _space = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                             target:nil
                             action:nil];

    // Top
    _toolbar_top = [UIToolbar new];
    _toolbar_top.barStyle = UIBarStyleBlackTranslucent;
    _toolbar_top.translatesAutoresizingMaskIntoConstraints = NO;
    [_toolbar_top
        setItems:@[ _btn_sys_1, _space, _btn_title_2, _space, _btn_sys_2 ]];
    _toolbar_top.delegate = self;
    //    [_toolbar_top setBackgroundImage:[UIImage new]
    //    forToolbarPosition:UIBarPositionTopAttached
    //    barMetrics:UIBarMetricsCompact];

    // Bottom
    _toolbar_bottom = [UIToolbar new];
    _toolbar_bottom.translatesAutoresizingMaskIntoConstraints = NO;
    [_toolbar_bottom
        setItems:@[ _btn_sys_3, _space, _btn_custom, _space, _btn_title_1 ]];
    _toolbar_bottom.barStyle = UIBarStyleBlackTranslucent;

    [self.view addSubview:_toolbar_top];
    [self.view addSubview:_toolbar_bottom];

    UILabel* label = [[UILabel alloc] init];
    label.text = @"adsfagaegaeoghpaoh";
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    label.textColor = UIColor.blackColor;
    [self.view addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
      [_toolbar_top.topAnchor
          constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
      [_toolbar_top.leadingAnchor
          constraintEqualToAnchor:self.view.leadingAnchor],
      [_toolbar_top.trailingAnchor
          constraintEqualToAnchor:self.view.trailingAnchor],
      //                                              [_toolbar_top.bottomAnchor
      //                                              constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor
      //                                              constant:_toolbar_top.intrinsicContentSize.height],
      [_toolbar_bottom.leadingAnchor
          constraintEqualToAnchor:self.view.leadingAnchor],
      [_toolbar_bottom.trailingAnchor
          constraintEqualToAnchor:self.view.trailingAnchor],
      [_toolbar_bottom.bottomAnchor
          constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];

    UIButton* imageButton2 =
        [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    imageButton2.enabled = NO;
    [imageButton2
        setImage:[new_tab_incognito
                     imageWithRenderingMode:UIImageRenderingModeAutomatic]
        forState:UIControlStateNormal];
    [self.view addSubview:imageButton2];

    //    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50,
    //    100, 40)]; [btn setTitle:@"button" forState:UIControlStateNormal];
    //    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    //    [btn setTitle:@"button!!!" forState:UIControlStateHighlighted];
    //    [btn setTitleColor:UIColor.redColor
    //    forState:UIControlStateHighlighted]; [btn addTarget:self
    //    action:@selector(onShit)
    //    forControlEvents:UIControlEventTouchUpInside]; [self.view
    //    addSubview:btn];
  }
  return self;
}

- (void)onShit {
  NSLog(@"shit");
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  return UIBarPositionTopAttached;
}

@end
