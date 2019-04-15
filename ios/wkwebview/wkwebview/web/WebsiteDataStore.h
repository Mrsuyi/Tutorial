//
//  DataStorage.h
//  wkwebview
//
//  Created by Yi Su on 4/12/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef WebsiteDataStorage_h
#define WebsiteDataStorage_h

#import <WebKit/WebKit.h>

WKWebsiteDataStore* GetRegularWKWebsiteDataStore(void);
WKWebsiteDataStore* GetIncognitoWKWebsiteDataStore(void);

#endif /* WebsiteDataStorage_h */
