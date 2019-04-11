//
//  main.m
//  foundation
//
//  Created by Yi Su on 03/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "url/UrlAppDelegate.h"
#import "control/CtrlAppDelegate.h"
#import "autolayout/AutoLayoutAppDelegate.h"

#import "cpp.hpp"

void test(const Shit& shit) {
//  Shit s = shit;
  __block Shit s = shit;
  auto block = ^() {
    printf("this is shit:%d\n", s.value);
  };
  block();
  block();
  block();
  block();
}

void test_cpp(const Shit& shit) {
  auto lambda = [shit]() {
    printf("this is shit:%d\n", shit.value);
  };
  lambda();
}

int main(int argc, char * argv[]) {
  
  Shit shit;
  test(shit);
  
  @autoreleasepool {
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([AutoLayoutAppDelegate class]));
  }
}
