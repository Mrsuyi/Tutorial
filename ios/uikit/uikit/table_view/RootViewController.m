//
//  ViewController.m
//  uikit
//
//  Created by Yi Su on 3/25/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "RootViewController.h"
#import "TableViewController.h"

@implementation RootViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;

  UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
  [btn setTitle:@"present" forState:UIControlStateNormal];
  [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
  [btn setTitleColor:UIColor.redColor forState:UIControlStateHighlighted];
  [btn addTarget:self action:@selector(onPresent:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)onPresent:(UIButton*)btn {
  UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:[TableViewController new]];
  [self presentViewController:nvc animated:YES completion:^{
    NSLog(@"presented!");
  }];
}

@end
