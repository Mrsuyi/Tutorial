//
//  ErrorPage.m
//  wkwebview
//
//  Created by Yi Su on 05/11/2019.
//  Copyright © 2019 google. All rights reserved.
//

#import "ErrorPage.h"

@interface ErrorPage ()
@property(nonatomic, strong) NSError* error;
@end

@implementation ErrorPage

@synthesize errorPageFileURL = _errorPageFileURL;
@synthesize errorPageContent = _errorPageContent;

- (instancetype)initWithError:(NSError*)error {
  if (self = [super init]) {
    _error = error;
  }
  return self;
}

- (NSString*)originalURL {
  return self.error.userInfo[NSURLErrorFailingURLStringErrorKey];
}

- (NSURL*)errorPageFileURL {
  if (!_errorPageFileURL) {
    NSString* encodedOriginalURL =
        [self.originalURL stringByAddingPercentEncodingWithAllowedCharacters:
                              NSCharacterSet.URLQueryAllowedCharacterSet];
    NSString* filePath = [NSBundle.mainBundle pathForResource:@"error_page_file"
                                                       ofType:@"html"];
    NSString* pathURL =
        [NSString stringWithFormat:@"file://%@&url=%@&error=%@&dontReload=%@",
                                   filePath, encodedOriginalURL,
                                   _error.localizedRecoverySuggestion, @"true"];
    _errorPageFileURL = [NSURL URLWithString:pathURL];
  }
  return _errorPageFileURL;
}

- (NSString*)errorPageContent {
  if (!_errorPageContent) {
    _errorPageContent = nil;
  }
  return _errorPageContent;
}

- (BOOL)knowURL:(NSURL*)url {
  return TRUE;
}

@end
