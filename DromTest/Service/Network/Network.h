//
//  Network.h
//  DromTest
//
//  Created by Victor on 04/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum {
    HTTPMethodGet,
    HTTPMethodPost
} HTTPMethod;

@interface Network : NSObject
typedef void (^ SuccessBlock)(NSData*);
typedef void (^ FailedBlock)(NSError*);

-(void)getRequestWithUrlString: (NSString*) urlString withSuccessCompletion: (SuccessBlock) successBlock withFailedCompletion: (FailedBlock) failedBlock;
-(void)postRequestWithUrlString: (NSString*) urlString withSuccessCompletion: (SuccessBlock) successBlock withBodyParameters: (NSDictionary *) parameters withFailedCompletion: (FailedBlock) failedBlock;
@end
