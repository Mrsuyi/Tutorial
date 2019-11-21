//
//  main.m
//  foundation
//
//  Created by Yi Su on 03/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "autolayout/AutoLayoutAppDelegate.h"
#import "control/CtrlAppDelegate.h"
#import "url/UrlAppDelegate.h"

int main(int argc, char* argv[]) {
  @autoreleasepool {
    NSMutableArray* ary = [NSMutableArray arrayWithCapacity:3UL];
    auto block = ^{
      [ary addObject:@"shit"];
    };
    block();
    NSLog(@"%lu", [ary count]);
    return 0;
    //      return UIApplicationMain(argc, argv, nil,
    //      NSStringFromClass([AutoLayoutAppDelegate class]));
  }
}
