//
//  main.m
//  uikit
//
//  Created by Yi Su on 02/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "basic/BasicAppDelegate.h"
#import "collection_view/CollectionViewAppDelegate.h"
#import "table_view/TableViewAppDelegate.h"
#import "toolbar/ToolbarAppDelegate.h"

int main(int argc, char* argv[]) {
  @autoreleasepool {
    return UIApplicationMain(argc, argv, nil,
                             NSStringFromClass([BasicAppDelegate class]));
    //    return UIApplicationMain(argc, argv, nil,
    //    NSStringFromClass([CollectionViewAppDelegate class])); return
    //    UIApplicationMain(argc, argv, nil,
    //    NSStringFromClass([TableViewAppDelegate class])); return
    //    UIApplicationMain(argc, argv, nil,
    //    NSStringFromClass([ToolbarAppDelegate class]));
  }
}
