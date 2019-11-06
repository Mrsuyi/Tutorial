//
//  ErrorPage.m
//  wkwebview
//
//  Created by Yi Su on 05/11/2019.
//  Copyright © 2019 google. All rights reserved.
//

#import "ErrorPage.h"

NSString* encodeHTML(NSString* text) {
  return
      [[[[[text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]
          stringByReplacingOccurrencesOfString:@"\""
                                    withString:@"&quot;"]
          stringByReplacingOccurrencesOfString:@"'"
                                    withString:@"&#39;"]
          stringByReplacingOccurrencesOfString:@">"
                                    withString:@"&gt;"]
          stringByReplacingOccurrencesOfString:@"<"
                                    withString:@"&lt;"];
}

@interface ErrorPage ()
@property(nonatomic, strong) NSError* error;
@end

@implementation ErrorPage

@synthesize originalURL = _originalURL;
@synthesize fileURL = _fileURL;
@synthesize html = _html;

- (instancetype)initWithError:(NSError*)error {
  if (self = [super init]) {
    _error = error;
  }
  return self;
}

- (NSURL*)originalURL {
  if (!_originalURL) {
    _originalURL = [NSURL URLWithString:self.originalURLString];
  }
  return _originalURL;
}

- (NSString*)originalURLString {
  return self.error.userInfo[NSURLErrorFailingURLStringErrorKey];
}

- (NSURL*)fileURL {
  if (!_fileURL) {
    NSURLQueryItem* itemURL =
        [NSURLQueryItem queryItemWithName:@"url" value:self.originalURLString];
    NSURLQueryItem* itemError =
        [NSURLQueryItem queryItemWithName:@"error"
                                    value:_error.localizedDescription];
    NSURLQueryItem* itemDontReload =
        [NSURLQueryItem queryItemWithName:@"dontReload" value:@"true"];
    NSURLComponents* url = [[NSURLComponents alloc] initWithString:@"file:///"];
    url.path = [NSBundle.mainBundle pathForResource:@"error_page_file"
                                             ofType:@"html"];
    url.queryItems = @[ itemURL, itemError, itemDontReload ];
    NSAssert(url.URL, @"file URL should be valid");
    _fileURL = url.URL;
  }
  return _fileURL;
}

- (NSString*)html {
  if (!_html) {
    NSString* path = [NSBundle.mainBundle pathForResource:@"error_page_string"
                                                   ofType:@"html"];
    NSAssert(path, @"error_page_string.html should exist");
    NSString* template = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    NSString* originalURLString = encodeHTML(self.originalURLString);
    NSString* errorInfo = encodeHTML(self.error.localizedDescription);
    _html = [NSString stringWithFormat:template, originalURLString,
                                       originalURLString, errorInfo];
  }
  return _html;
}

- (BOOL)matchURL:(NSURL*)url {
  // Check that |url| is a file URL of error page.
  if (!url.fileURL || ![url.path isEqualToString:self.fileURL.path]) {
    return NO;
  }
  // Check that |url| has the same original URL as |self|.
  NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url
                                              resolvingAgainstBaseURL:NO];
  NSURL* originalURL = nil;
  for (NSURLQueryItem* item in urlComponents.queryItems) {
    if ([item.name isEqualToString:@"url"]) {
      originalURL = [NSURL URLWithString:item.value];
      break;
    }
  }
  return [originalURL isEqual:self.originalURL];
}

@end
