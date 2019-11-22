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
    NSArray* arrayForEncoding = @[
      @"<!--<!DOCTYPE html>-->\r\n<html>\r\n<head>\r\n    <script>\r\n        console.log('shit');\r\n        window.onpageshow=()=>{console.log('shit');};\r\n    </script>\r\n</head>\r\n<body>asdfasdf</body>\r\n</html>"
    ];
    NSString* jsonString = [[NSString alloc]
        initWithData:[NSJSONSerialization dataWithJSONObject:arrayForEncoding
                                                     options:0
                                                       error:nil]
            encoding:NSUTF8StringEncoding];
    NSString* escapedString =
        [jsonString substringWithRange:NSMakeRange(2, jsonString.length - 4)];
    NSLog(@"%@", escapedString);

    return 0;
    //      return UIApplicationMain(argc, argv, nil,
    //      NSStringFromClass([AutoLayoutAppDelegate class]));
  }
}
