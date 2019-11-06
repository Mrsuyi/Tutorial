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
    NSString* encodedOriginalURL = [self.originalURLString
        stringByAddingPercentEncodingWithAllowedCharacters:
            NSCharacterSet.URLQueryAllowedCharacterSet];
    NSString* encodedErrorInfo = [_error.localizedDescription
        stringByAddingPercentEncodingWithAllowedCharacters:
            NSCharacterSet.URLQueryAllowedCharacterSet];
    NSString* filePath = [NSBundle.mainBundle pathForResource:@"error_page_file"
                                                       ofType:@"html"];
    NSString* pathURL = [NSString
        stringWithFormat:@"file://%@?url=%@&error=%@&dontReload=true", filePath,
                         encodedOriginalURL, encodedErrorInfo];
    _fileURL = [NSURL URLWithString:pathURL];
  }
  return _fileURL;
}

- (NSString*)html {
  if (!_html) {
    NSString* path = [NSBundle.mainBundle pathForResource:@"error_page_content"
                                                   ofType:@"html"];
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
  NSString* originalURL = nil;
  NSArray<NSString*>* kvs = [url.query componentsSeparatedByString:@"&"];
  for (NSString* kv in kvs) {
    NSRange range = [kv rangeOfString:@"url="];
    if (range.location != NSNotFound) {
      originalURL = [kv substringFromIndex:range.location + range.length];
      break;
    }
  }
  return originalURL && [originalURL isEqualToString:self.originalURLString];
}

@end
