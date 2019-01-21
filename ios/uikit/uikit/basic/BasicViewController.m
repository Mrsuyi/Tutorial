//
//  BasicViewController.m
//  uikit
//
//  Created by Yi Su on 1/10/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "BasicViewController.h"
#import "Button.h"

@implementation BasicViewController {
  UIImageView* _imageView;
  Button* _btn;
  UITapGestureRecognizer* _tapper;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.view.backgroundColor = UIColor.whiteColor;
    
    //    UIImage* image = [UIImage imageNamed:@"m.png"];
    //    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 60, 100)];
    //    _imageView.image = image;
    //    _imageView.clipsToBounds = YES;
    //    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    //
    //    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    //
    //    [self.view addSubview:_imageView];
    
    _btn = [Button new];
    _btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_btn];
    [NSLayoutConstraint activateConstraints:@[
                                              [_btn.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
                                              [_btn.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:100],
                                              [_btn.widthAnchor constraintEqualToConstant:128],
                                              [_btn.heightAnchor
                                               constraintEqualToConstant:128],
                                              ]];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  NSLog(@"%@", NSStringFromCGRect(_btn.frame));
  NSLog(@"%@", NSStringFromCGRect(_btn.bounds));
  NSLog(@"%@", NSStringFromCGSize(_btn.imageView.intrinsicContentSize));
}

- (void) onShit {
  NSLog(@"shit");
}

@end

