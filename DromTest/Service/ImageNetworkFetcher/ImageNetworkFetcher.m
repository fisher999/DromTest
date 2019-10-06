//
//  ImageNetworkFetcher.m
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageNetworkFetcher.h"
#import "Network.h"

@interface ImageNetworkFetcher ()
@property (strong, nonatomic) ImageDataStorage *imageStorage;
@property (strong, nonatomic) Network *network;
@end

@implementation ImageNetworkFetcher

- (instancetype)init
{
    if (self = [super init]) {
        _imageStorage = [[ImageDataStorage alloc] init];
        _network = [[Network alloc] init];
    }
    
    return self;
}

- (void)getImage:(NSString *)urlString withSuccessCompletion:(NFSuccessBlock)successBlock andFailedCompletion:(FailedBlock)failedBlock {
    @try {
        NSArray<MDImage *> *images = [self.imageStorage getImages];
        for (MDImage *image in images) {
            if ([image.imageUrl isEqualToString:urlString]) {
                successBlock(image);
                return;
            }
        }
        
        [self.network getRequestWithUrlString:urlString withSuccessCompletion:^(NSData *data){
            ImageNetworkFetcher *  __weak weakSelf = self;
            MDImage *image = [[MDImage alloc] initWithImageUrl:urlString andImageData:data];
            [weakSelf.imageStorage addImage:image];
            [weakSelf.imageStorage save];
            successBlock([[MDImage alloc] initWithImageUrl:urlString andImageData:data]);
        } withFailedCompletion:failedBlock];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}
@end
