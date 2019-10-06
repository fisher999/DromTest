//
//  MainView.h
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainViewPresenter;

@protocol MainView
@property (strong, nonatomic) MainViewPresenter *presenter;

- (void)didRefresh;
- (void)imageDataDidLoad:(NSData *) imageData atIndexPath: (NSIndexPath *) indexPath;
- (void)removedImageAtIndexPath: (NSIndexPath *) indexPath;
@end
