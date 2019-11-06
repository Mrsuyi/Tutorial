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
    NSURL* url =
        [NSURL URLWithString:@"https://mrsuyi:shit@www.google.com:1234/aaa/"
                             @"bbb.html?key=value&x=1"];
    NSString* query = url.query;
    NSArray<NSString*>* queries = [query componentsSeparatedByString:@"&"];
    NSString* x;
    for (NSString* kv : queries) {
      NSRange range = [kv rangeOfString:@"x="];
      if (range.length != 0) {
        x = [kv substringFromIndex:range.location + range.length];
        break;
      }
    }
    NSLog(@"%@", x);
    return 0;
    //      return UIApplicationMain(argc, argv, nil,
    //      NSStringFromClass([AutoLayoutAppDelegate class]));
  }
}
