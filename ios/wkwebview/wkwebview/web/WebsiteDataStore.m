//
//  DataStorage.m
//  wkwebview
//
//  Created by Yi Su on 4/12/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "WebsiteDataStore.h"

WKWebsiteDataStore* kRegularStore = nil;
WKWebsiteDataStore* kIncognitoStore = nil;

WKWebsiteDataStore* GetRegularWKWebsiteDataStore() {
  if (!kRegularStore) {
    kRegularStore = [WKWebsiteDataStore defaultDataStore];
  }
  return kRegularStore;
}

WKWebsiteDataStore* GetIncognitoWKWebsiteDataStore() {
  if (!kIncognitoStore) {
    kIncognitoStore = [WKWebsiteDataStore nonPersistentDataStore];
  }
  return kIncognitoStore;
}
