//
//  WebViewConfiguration.h
//  wkwebview
//
//  Created by Yi Su on 4/19/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WebViewConfiguration_h
#define WebViewConfiguration_h

#import <WebKit/WebKit.h>

WKWebViewConfiguration* GetRegularWKWebViewConfiguration(void);
WKWebViewConfiguration* GetIncognitoWKWebViewConfiguration(void);

#endif /* WebViewConfiguration_h */
