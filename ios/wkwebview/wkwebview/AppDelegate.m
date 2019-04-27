//
//  AppDelegate.m
//  wkwebview
//
//  Created by Yi Su on 4/8/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "web/WebViewConfiguration.h"
#import "web/LocalSchemeHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Launching

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSLog(@"application:willFinishLaunchingWithOptions:");

  // Init web.
  [GetIncognitoWKWebViewConfiguration() setURLSchemeHandler:[LocalSchemeHandler defaultHandler] forURLScheme:[LocalSchemeHandler scheme]];
  [GetRegularWKWebViewConfiguration() setURLSchemeHandler:[LocalSchemeHandler defaultHandler] forURLScheme:[LocalSchemeHandler scheme]];

  // Create window.
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  ViewController* mainVC = [[ViewController alloc] init];
  self.window.rootViewController = mainVC;

  return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSLog(@"application:didFinishLaunchingWithOptions:");
  [self.window makeKeyAndVisible];
  return YES;
}

- (BOOL)application:(UIApplication*)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
  completionHandler(YES);
}

#pragma mark - Restoration

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
  NSLog(@"application:shouldSaveApplicationState:");
  return NO;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
  NSLog(@"application:shouldRestoreApplicationState:");
  return NO;
}

- (UIViewController*)application:(UIApplication *)application
viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents
                           coder:(NSCoder *)coder {
  NSLog(@"application:viewControllerWithRestorationIdentifierPath:coder:");
  NSAssert(NO, @"This function should never be called");
  return nil;
}

#pragma mark - Transition

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
