//
//  WebViewConfiguration.m
//  wkwebview
//
//  Created by Yi Su on 4/19/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebViewConfiguration.h"
#import "WebsiteDataStore.h"

WKWebViewConfiguration* kRegularConf = nil;
WKWebViewConfiguration* kIncognitoConf = nil;

WKWebViewConfiguration* GetRegularWKWebViewConfiguration() {
  if (!kRegularConf) {
    kRegularConf = [[WKWebViewConfiguration alloc] init];
    kRegularConf.websiteDataStore = GetRegularWKWebsiteDataStore();
  }
  return kRegularConf;
}

WKWebViewConfiguration* GetIncognitoWKWebViewConfiguration() {
  if (!kIncognitoConf) {
    kIncognitoConf = [[WKWebViewConfiguration alloc] init];
    kIncognitoConf.websiteDataStore = GetIncognitoWKWebsiteDataStore();
  }
  return kIncognitoConf;
}
