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

@synthesize failedURL = _failedURL;
@synthesize fileURL = _fileURL;
@synthesize injectScript = _injectScript;

- (instancetype)initWithError:(NSError*)error {
  if (self = [super init]) {
    _error = error;
  }
  return self;
}

- (NSURL*)failedURL {
  if (!_failedURL) {
    _failedURL = [NSURL URLWithString:self.failedURLString];
  }
  return _failedURL;
}

- (NSString*)failedURLString {
  return self.error.userInfo[NSURLErrorFailingURLStringErrorKey];
}

- (NSURL*)fileURL {
  if (!_fileURL) {
    NSURLQueryItem* itemURL =
        [NSURLQueryItem queryItemWithName:@"url" value:self.failedURLString];
    NSURLQueryItem* itemError =
        [NSURLQueryItem queryItemWithName:@"error"
                                    value:_error.localizedDescription];
    NSURLQueryItem* itemDontLoad = [NSURLQueryItem queryItemWithName:@"dontLoad"
                                                               value:@"true"];
    NSURLComponents* url = [[NSURLComponents alloc] initWithString:@"file:///"];
    url.path = [NSBundle.mainBundle pathForResource:@"error_page_file"
                                             ofType:@"html"];
    url.queryItems = @[ itemURL, itemError, itemDontLoad ];
    NSAssert(url.URL, @"file URL should be valid");
    _fileURL = url.URL;
  }
  return _fileURL;
}

- (NSString*)injectScript {
  if (!_injectScript) {
    NSString* path = [NSBundle.mainBundle pathForResource:@"error_page_string"
                                                   ofType:@"html"];
    NSAssert(path, @"error_page_string.html should exist");
    NSString* htmlTemplate =
        [NSString stringWithContentsOfFile:path
                                  encoding:NSUTF8StringEncoding
                                     error:nil];
    NSString* failedURLString = encodeHTML(self.failedURLString);
    NSString* errorInfo = encodeHTML(self.error.localizedDescription);
    NSString* html = [NSString stringWithFormat:htmlTemplate, failedURLString,
                                                failedURLString, errorInfo];
    NSString* json = [[NSString alloc]
        initWithData:[NSJSONSerialization dataWithJSONObject:@[ html ]
                                                     options:0
                                                       error:nil]
            encoding:NSUTF8StringEncoding];
    NSString* escapedHtml =
        [json substringWithRange:NSMakeRange(1, json.length - 2)];

    _injectScript =
        [NSString stringWithFormat:
                      @"document.open(); document.write(%@); document.close();",
                      escapedHtml];

    NSLog(@"%@", _injectScript);
  }
  return _injectScript;
}

- (BOOL)matchURL:(NSURL*)url {
  // Check that |url| is a file URL of error page.
  if (!url.fileURL || ![url.path isEqualToString:self.fileURL.path]) {
    return NO;
  }
  // Check that |url| has the same failed URL as |self|.
  NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url
                                              resolvingAgainstBaseURL:NO];
  NSURL* failedURL = nil;
  for (NSURLQueryItem* item in urlComponents.queryItems) {
    if ([item.name isEqualToString:@"url"]) {
      failedURL = [NSURL URLWithString:item.value];
      break;
    }
  }
  return [failedURL isEqual:self.failedURL];
}

@end
