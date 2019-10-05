//
//  MDImage.m
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDImage.h"

#define kMDImageUrl @"image_key"
#define kMDImageData @"image_data"

@implementation MDImage
- (instancetype)initWithImageUrl: (NSString *) imageUrl {
    self = [super init];
    if (self) {
        self.imageUrl = imageUrl;
    }
    
    return self;
}

- (instancetype)initWithImageUrl:(NSString *)imageUrl andImageData: (NSData *) imageData {
    self = [super init];
    if (self) {
        self.imageUrl = imageUrl;
        self.imageData = imageData;
    }
    
    return self;
}



- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_imageUrl forKey:kMDImageUrl];
    [aCoder encodeObject:_imageData forKey:kMDImageData];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.imageUrl = [aDecoder decodeObjectForKey:kMDImageUrl];
        self.imageData = [aDecoder decodeObjectForKey:kMDImageData];
    }
    return self;
}
@end
