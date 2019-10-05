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
@property (strong, nonatomic) NSArray<MDImage *> *images;
-(NSString *)filePath;
@end

@implementation ImageDataStorage

- (instancetype)init {
    if (self = [super init]) {
        self.images = [self getImages];
    }
    
    return self;
}

- (NSArray<MDImage *> *)getImages {
    NSDictionary<NSString *, NSData *> *dictionary = (NSDictionary<NSString *, NSData *> *)[NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    NSMutableArray<MDImage *> *images = [NSMutableArray<MDImage *> array];
    for (NSString *key in dictionary.allKeys) {
        [images addObject:[MDImage initWithImageUrl:key andImageData:dictionary[key]]];
    }
    
    return images;
}

- (void)saveImages:(NSArray<MDImage *> *)images {
    [NSKeyedArchiver archiveRootObject:images toFile:[self filePath]];
}

@end

@implementation ImageDataStorage (Private)

- (NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    return [url URLByAppendingPathComponent:kFilePath].path;
}

@end

