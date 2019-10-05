//
//  MDImage.h
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDImage : NSObject<NSCoding>
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSData* imageData;

+ (instancetype)initWithImageUrl: (NSString *) imageUrl;
+ (instancetype)initWithImageUrl:(NSString *)imageUrl andImageData: (NSData *) imageData;

@end

