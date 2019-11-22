//
//  ErrorPage.h
//  wkwebview
//
//  Created by Yi Su on 05/11/2019.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef ErrorPage_h
#define ErrorPage_h

#import <WebKit/WebKit.h>

@interface ErrorPage : NSObject

// Failed URL of the failed navigation.
@property(nonatomic, strong, readonly) NSURL* failedURL;
@property(nonatomic, strong, readonly) NSString* failedURLString;
// The error page file to be loaded as a new page.
@property(nonatomic, strong, readonly) NSURL* fileURL;
// The error page html to be injected into existing page.
@property(nonatomic, strong, readonly) NSString* injectHTML;
// The error page HTML content to be injected into current page.
@property(nonatomic, strong, readonly) NSString* injectScript;

- (instancetype)initWithError:(NSError*)error;

// Returns TRUE if |url| is a file URL for this error page.
- (BOOL)matchURL:(NSURL*)url;

@end

#endif /* ErrorPage_h */
