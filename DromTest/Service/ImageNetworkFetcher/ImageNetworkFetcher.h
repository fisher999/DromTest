//
//  ImageNetworkFetcher.h
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDataStorage.h"
#import "Network.h"

@interface ImageNetworkFetcher : NSObject
typedef void (^ NFSuccessBlock)(MDImage*);

-(void)getImage: (NSString *) urlString withSuccessCompletion: (NFSuccessBlock) successBlock andFailedCompletion: (FailedBlock) failedBlock;
@end
