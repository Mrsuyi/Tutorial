//
//  WKNavigationHandler.h
//  wkwebview
//
//  Created by Yi Su on 7/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WKNavigationHandler_h
#define WKNavigationHandler_h

#import <WebKit/WebKit.h>

@class NavigationHandler;

@protocol NavigationDelegate <NSObject>
- (void)navigationHandlerDidStartLoading:(NavigationHandler*)navigationHandler;
- (void)navigationHandlerDidStopLoading:(NavigationHandler*)navigationHandler;
@end

@interface NavigationHandler : NSObject <WKNavigationDelegate>
@property(nonatomic, weak) id<NavigationDelegate> delegate;
@end

#endif /* WKNavigationHandler_h */
