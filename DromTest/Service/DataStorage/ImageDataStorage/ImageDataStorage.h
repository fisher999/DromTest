//
//  ImageDataStorage.h
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDImage.h"

@interface ImageDataStorage : NSObject
- (NSArray<MDImage *> *)getImages;
- (void)save;
- (void)addImage: (MDImage *) image;
@end
