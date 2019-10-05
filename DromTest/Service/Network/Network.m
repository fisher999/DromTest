//
//  Network.m
//  DromTest
//
//  Created by Victor on 04/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"
#import "MDImage.h"

#pragma mark -define Private methods
@interface Network ()

- (void)baseRequest: (NSString*) method withUrlString: (NSString *) urlString withSuccessCompletion: (SuccessBlock) successBlock withFailedCompletion: (FailedBlock) failedBlock withParameters: (NSDictionary *) parameters;

- (void)request: (HTTPMethod) httpMethod withUrlString: (NSString*) urlString withSuccessCompletion: (SuccessBlock) successBlock withFailedCompletion: (FailedBlock) failedBlock withParameters: (NSDictionary *) parameters;
@end


@implementation Network
- (void)getRequestWithUrlString:(NSString *)urlString withSuccessCompletion:(SuccessBlock)successBlock withFailedCompletion:(FailedBlock)failedBlock {
    [self request:HTTPMethodGet withUrlString:urlString withSuccessCompletion:successBlock withFailedCompletion:failedBlock withParameters:nil];
}

- (void)postRequestWithUrlString:(NSString *)urlString withSuccessCompletion:(SuccessBlock)successBlock withBodyParameters:(NSDictionary *)parameters withFailedCompletion:(FailedBlock)failedBlock {
    [self request:HTTPMethodGet withUrlString:urlString withSuccessCompletion:successBlock withFailedCompletion:failedBlock withParameters:parameters];
}

@end

#pragma mark -implements Private methods
@implementation Network (Private)
- (void)baseRequest: (NSString*) method withUrlString: (NSString *) urlString withSuccessCompletion: (SuccessBlock) successBlock withFailedCompletion: (FailedBlock) failedBlock withParameters: (NSDictionary *) parameters {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:method];
    [request setURL: url];
    if (parameters != nil) {
        NSData *body = [self dataFromDictionary:parameters];
        [request setHTTPBody:body];
    }
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          if (error) {
              failedBlock(error);
          }
          if (data) {
              successBlock(data);
          }
      }] resume];
}

- (NSData *)dataFromDictionary: (NSDictionary *) parameters {
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
}

- (void)request: (HTTPMethod) httpMethod withUrlString: (NSString*) urlString withSuccessCompletion: (SuccessBlock) successBlock withFailedCompletion: (FailedBlock) failedBlock withParameters:(NSDictionary *)parameters  {
    switch (httpMethod) {
        case HTTPMethodGet:
            [self baseRequest:@"GET" withUrlString:urlString withSuccessCompletion:successBlock withFailedCompletion:failedBlock withParameters: parameters];
        case HTTPMethodPost:
            [self baseRequest:@"GET" withUrlString:urlString withSuccessCompletion:successBlock withFailedCompletion:failedBlock withParameters: parameters];
    }
}
@end
