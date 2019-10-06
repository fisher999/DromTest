//
//  ImageDataStorage.m
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDataStorage.h"

NSString *const kFilePath = @"imageData";

#pragma mark -Private
@interface ImageDataStorage()
@property (strong, nonatomic) NSMutableArray<MDImage *> *images;
-(NSString *)filePath;
@end

@implementation ImageDataStorage

- (instancetype)init {
    if (self = [super init]) {
        self.images = [[NSMutableArray<MDImage *> alloc] initWithArray:[self getImages]];
    }
    
    return self;
}

- (NSArray<MDImage *> *)getImages {
    if (self.images) {
        return self.images;
    }
    @try {
        NSArray<MDImage *> *array = (NSArray<MDImage *> *)[NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
        return array;
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:_images toFile:[self filePath]];
}

- (void)addImage:(MDImage *)image {
    for (MDImage *savedImage in _images) {
        if ([savedImage.imageUrl isEqualToString:image.imageUrl]) {
            return;
        }
    }
    [_images addObject:image];
}

@end

@implementation ImageDataStorage (Private)

- (NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    return [url URLByAppendingPathComponent:kFilePath].path;
}

@end

