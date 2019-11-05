//
//  ErrorPage.h
//  wkwebview
//
//  Created by Yi Su on 05/11/2019.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef ErrorPage_h
#define ErrorPage_h

#import <Foundation/Foundation.h>

@interface ErrorPage : NSObject

@property(nonatomic, strong, readonly) NSString* originalURL;
@property(nonatomic, strong, readonly) NSURL* errorPageFileURL;
@property(nonatomic, strong, readonly) NSString* errorPageContent;

- (instancetype)initWithError:(NSError*)error;

// Returns TRUE if |url| is a file URL for this error page.
- (BOOL)knowURL:(NSURL*)url;

@end

#endif /* ErrorPage_h */
