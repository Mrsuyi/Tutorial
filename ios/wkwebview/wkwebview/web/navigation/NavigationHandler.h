//
//  WKNavigationHandler.h
//  wkwebview
//
//  Created by Yi Su on 7/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WKNavigationHandler_h
#define WKNavigationHandler_h

#import "../WebView.h"

@class NavigationHandler;

@protocol NavigationHandlerDelegate <NSObject>
- (void)navigationHandler:(NavigationHandler*)navigationHandler
    didFinishNavigationWithError:(NSError*)error;
@end

@interface NavigationHandler : NSObject <WKNavigationDelegate>
@property(nonatomic, weak) id<NavigationHandlerDelegate> delegate;
@end

#endif /* WKNavigationHandler_h */
