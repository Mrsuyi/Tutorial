//
//  FileSchemeHandler.h
//  wkwebview
//
//  Created by Yi Su on 4/19/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef LocalSchemeHandler_h
#define LocalSchemeHandler_h

#import <WebKit/WebKit.h>

// Handles local:// scheme by loading the local file with request URL's path.
// e.g. When requesting "local:///Users/xxx/index.html",
// "file:///Users/xxx/index.html" will be loaded and returned.
@interface LocalSchemeHandler : NSObject <WKURLSchemeHandler>

+ (NSString*)scheme;
+ (instancetype)defaultHandler;

@end

#endif /* LocalSchemeHandler_h */
