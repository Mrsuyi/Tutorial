//
//  ViewController.m
//  url
//
//  Created by Yi Su on 03/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import "ViewController.h"

#import "button.h"

@implementation ViewController {
  Button* _btn;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.view.backgroundColor = UIColor.whiteColor;

  _btn = [[Button alloc] initWithTitle:@"shit" frame:CGRectMake(20, 50, 100, 50)];

  [self.view addSubview:_btn];
}


@end
