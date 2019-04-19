//
//  FileSchemeHandler.m
//  wkwebview
//
//  Created by Yi Su on 4/19/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "LocalSchemeHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>

LocalSchemeHandler* kDefaultLocalShcemeHandler = nil;

@implementation LocalSchemeHandler

#pragma mark - WKURLSchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask {
  NSLog(@"webView:startURLSchemeTask:");
  NSString* log = [NSString stringWithFormat:@"LocalSchemeHandler should only handle %@", [LocalSchemeHandler scheme]];
  NSAssert([urlSchemeTask.request.URL.scheme isEqualToString:[LocalSchemeHandler scheme]], log);

  NSURLRequest* request = urlSchemeTask.request;
  NSData* data = [[NSFileManager defaultManager] contentsAtPath:request.URL.path];
  NSString* extension = request.URL.pathExtension;
  NSString* UTI = (__bridge_transfer NSString*)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
  NSString *MIMEType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
  NSURLResponse* response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:MIMEType expectedContentLength:data.length textEncodingName:@"UTF-8"];
  [urlSchemeTask didReceiveResponse:response];
  [urlSchemeTask didReceiveData:data];
  [urlSchemeTask didFinish];
}

- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask {
  NSLog(@"webView:stopURLSchemeTask");
}

+ (NSString*)scheme {
  return @"local";
}

+ (instancetype)defaultHandler {
  if (!kDefaultLocalShcemeHandler) {
    kDefaultLocalShcemeHandler = [[LocalSchemeHandler alloc] init];
  }
  return kDefaultLocalShcemeHandler;
}

@end
