//
//  MainViewPresenter.m
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewPresenter.h"
#import "ImageNetworkFetcher.h"

@interface MainViewPresenter ()
@property (weak, nonatomic) id<MainView> view;
@property (strong, nonatomic) ImageNetworkFetcher *imageNetworkFetcher;
@property (strong, nonatomic) NSMutableArray<MDImage *> *imagesArray;

-(NSArray<NSString *> *)urlStrings;
-(void)loadImages;
@end

@implementation MainViewPresenter
- (instancetype)initWithImageNetworkFetcher:(ImageNetworkFetcher *)imageNetworkFetcher andView:(id<MainView>) __weak view {
    if (self = [super init]) {
        self.imageNetworkFetcher = imageNetworkFetcher;
        self.view = view;
        self.imagesArray = [NSMutableArray new];
    }
    
    return self;
}

-(void) preload {
    for (NSString *url in [self urlStrings]) {
        [_imagesArray addObject:[[MDImage alloc] initWithImageUrl:url]];
    }
    [self loadImages];
}
@end

@implementation MainViewPresenter (Network)

- (void)loadImages {
    for (NSString *url in [self urlStrings]) {
            MainViewPresenter * __weak weakSelf = self;
            [weakSelf imageRequestWithUrlString:url];
    }
}

- (void)imageRequestWithUrlString:(NSString *)urlString {
    [self.imageNetworkFetcher getImage:urlString withSuccessCompletion:^(MDImage *image) {
        MainViewPresenter * __weak weakSelf = self;
        NSInteger index = [self setNewImage:image];
        [self.view didRefresh];
        [self.view imageDataDidLoad:image.imageData atIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [self.view didRefresh];
    } andFailedCompletion:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (NSInteger)setNewImage: (MDImage *) newImage {
    for (int index = 0; index < self.imagesArray.count; index++) {
        MDImage *image = self.imagesArray[index];
        if ([image.imageUrl isEqualToString:newImage.imageUrl]) {
            [self.imagesArray removeObjectAtIndex:index];
            [self.imagesArray insertObject:newImage atIndex:index];
            return index;
        }
    }
    
    return nil;
}

- (NSArray<NSString *> *)urlStrings {
    return [[NSArray<NSString *> alloc] initWithObjects:@"https://vddoma.ru/images/1/08c8f6e462b39ce4ed2a313a27ac105d.jpg",
            @"https://avatars.mds.yandex.net/get-pdb/49816/35aa600f-4b8c-4866-b32e-83db0ba53b5b/s1200?webp=false",
            @"https://images.rapgenius.com/0cac5574858c12b89138188f93823dce.1000x800x1.jpg",
            @"https://404store.com/2018/08/30/tumblr_n65qdyIdrI1tw2fe8o1_1280.jpg",
            @"https://avatars.yandex.net/get-music-user-playlist/69910/19223535.1004.56212/m1000x1000?1534486511464&webp=false",
            @"https://focusasiatravel.com/wp-content/uploads/2018/07/the-Golmud-Lhasa-Railway.png",nil];
}

@end

#pragma mark -View methods
@implementation MainViewPresenter (View)

-(NSInteger)count {
    return self.imagesArray.count;
}

- (NSData *)cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _imagesArray.count) {
        return _imagesArray[indexPath.row].imageData;
    }
    else {
        return nil;
    }
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self removeImageAtIndexPath:indexPath];
}

- (void)removeImageAtIndexPath: (NSIndexPath *) indexPath {
    [self.imagesArray removeObjectAtIndex:indexPath.row];
    [self.view removedImageAtIndexPath:indexPath];
}

- (void)didPullToRefresh {
    [self.imagesArray removeAllObjects];
    [self preload];
}

@end
