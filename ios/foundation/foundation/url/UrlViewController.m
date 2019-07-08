//
//  ViewController.m
//  foundation
//
//  Created by Yi Su on 03/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import "UrlViewController.h"
#import <Foundation/foundation.h>

@interface UrlViewController () <NSURLSessionDelegate,
                                 NSURLSessionDataDelegate> {
}
@end

@implementation UrlViewController {
  UIButton* _btn;
  UITextView* _textView;
  NSURLSession* _normalSession;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.whiteColor;

  // UI.
  _btn = [[UIButton alloc] initWithFrame:CGRectZero];
  _btn.translatesAutoresizingMaskIntoConstraints = NO;
  [_btn setTitle:@"shit" forState:UIControlStateNormal];
  [_btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
  [_btn addTarget:self
                action:@selector(onBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_btn];

  _textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
  _textView.translatesAutoresizingMaskIntoConstraints = NO;
  _textView.editable = NO;
  [self.view addSubview:_textView];

  NSDictionary* views = @{@"btn" : _btn, @"tv" : _textView};
  NSMutableArray<NSLayoutConstraint*>* constraints = [NSMutableArray new];
  [constraints addObjectsFromArray:[NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                           @"V:|-20-[btn]-10-[tv(>=200)]-10-|"
                                                           options:0
                                                           metrics:nil
                                                             views:views]];
  [constraints addObjectsFromArray:
                   [NSLayoutConstraint
                       constraintsWithVisualFormat:@"H:|-20-[btn]"
                                           options:NSLayoutFormatAlignAllCenterY
                                           metrics:nil
                                             views:views]];
  [constraints addObjectsFromArray:
                   [NSLayoutConstraint
                       constraintsWithVisualFormat:@"H:|-5-[tv]-5-|"
                                           options:NSLayoutFormatAlignAllCenterY
                                           metrics:nil
                                             views:views]];
  [NSLayoutConstraint activateConstraints:constraints];

  // URL.
  NSURLSessionConfiguration* config;

  config = NSURLSessionConfiguration.defaultSessionConfiguration;
  config.allowsCellularAccess = NO;
  config.timeoutIntervalForRequest = 5;
  config.timeoutIntervalForResource = 10;
  _normalSession = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];
}

- (void)onBtnClicked {
  NSLog(@"shit");
  NSURL* url = [NSURL URLWithString:@"https://www.google.com"];
  NSURLSessionDataTask* task = [_normalSession
        dataTaskWithURL:url
      completionHandler:^(NSData* data, NSURLResponse* response,
                          NSError* error) {
        if (!data) {
          NSLog(@"task response error: %@", error.userInfo);
          return;
        }
        NSLog(@"Data length: %lu", data.length);
        dispatch_async(dispatch_get_main_queue(), ^{
          NSStringEncoding encoding = NSUTF8StringEncoding;
          if (response.textEncodingName) {
            CFStringEncoding c = CFStringConvertIANACharSetNameToEncoding(
                (CFStringRef)response.textEncodingName);
            encoding = CFStringConvertEncodingToNSStringEncoding(c);
          }
          NSString* str = [[NSString alloc] initWithData:data
                                                encoding:encoding];
          self->_textView.text = str;
        });
      }];
  [task resume];
}

#pragma NSURLSessionDelegate

- (void)URLSession:(NSURLSession*)session
    didBecomeInvalidWithError:(NSError*)error {
  NSLog(@"URLSession:didBecomeInvalidWithError:");
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:
    (NSURLSession*)session {
  NSLog(@"URLSessionDidFinishEventsForBackgroundURLSession:");
}

- (void)URLSession:(NSURLSession*)session
    didReceiveChallenge:(NSURLAuthenticationChallenge*)challenge
      completionHandler:
          (void (^)(NSURLSessionAuthChallengeDisposition disposition,
                    NSURLCredential* credential))completionHandler {
  NSLog(@"URLSession:didReceiveChallenge:completionHandler:");
  completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, NULL);
}

#pragma NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession*)session
                    task:(NSURLSessionTask*)task
    didCompleteWithError:(NSError*)error {
  NSLog(@"URLSession:task:didCompleteWithError:");
}

- (void)URLSession:(NSURLSession*)session
                          task:(NSURLSessionTask*)task
    willPerformHTTPRedirection:(NSHTTPURLResponse*)response
                    newRequest:(NSURLRequest*)request
             completionHandler:(void (^)(NSURLRequest*))completionHandler {
  NSLog(@"URLSession:task:willPerformHTTPRedirection:newRequest:"
        @"completionHandler:");
  completionHandler(request);
}

- (void)URLSession:(NSURLSession*)session
                        task:(NSURLSessionTask*)task
             didSendBodyData:(int64_t)bytesSent
              totalBytesSent:(int64_t)totalBytesSent
    totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
  NSLog(@"URLSession:task:didSendBodyData:totalBytesSent:"
        @"totalBytesExpectedToSend:");
}

- (void)URLSession:(NSURLSession*)session
                 task:(NSURLSessionTask*)task
    needNewBodyStream:(void (^)(NSInputStream* bodyStream))completionHandler {
  NSLog(@"URLSession:task:needNewBodyStream:");
  completionHandler(nil);
}

- (void)URLSession:(NSURLSession*)session
                   task:(NSURLSessionTask*)task
    didReceiveChallenge:(NSURLAuthenticationChallenge*)challenge
      completionHandler:
          (void (^)(NSURLSessionAuthChallengeDisposition disposition,
                    NSURLCredential* credential))completionHandler {
  NSLog(@"URLSession:task:didReceiveChallenge:completionHandler:");
  completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, NULL);
}

#pragma NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession*)session
              dataTask:(NSURLSessionDataTask*)dataTask
    didReceiveResponse:(NSURLResponse*)response
     completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))
                           completionHandler {
  NSLog(@"URLSession:dataTask:didReceiveResponse:completionHandler:");
  completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession*)session
                 dataTask:(NSURLSessionDataTask*)dataTask
    didBecomeDownloadTask:(NSURLSessionDownloadTask*)downloadTask {
  NSLog(@"URLSession:dataTask:didBecomeDownloadTask:");
}

- (void)URLSession:(NSURLSession*)session
               dataTask:(NSURLSessionDataTask*)dataTask
    didBecomeStreamTask:(NSURLSessionStreamTask*)streamTask {
  NSLog(@"URLSession:dataTask:didBecomeStreamTask:");
}

- (void)URLSession:(NSURLSession*)session
          dataTask:(NSURLSessionDataTask*)dataTask
    didReceiveData:(NSData*)data {
  NSLog(@"URLSession:dataTask:didReceiveData");
}

- (void)URLSession:(NSURLSession*)session
             dataTask:(NSURLSessionDataTask*)dataTask
    willCacheResponse:(NSCachedURLResponse*)proposedResponse
    completionHandler:
        (void (^)(NSCachedURLResponse* cachedResponse))completionHandler {
  NSLog(@"URLSession:dataTask:willCacheResponse:completionHandler");
  completionHandler(proposedResponse);
}

@end
