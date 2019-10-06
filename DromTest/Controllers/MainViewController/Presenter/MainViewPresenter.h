//
//  MainViewPresenter.h
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageNetworkFetcher.h"
#import "MainView.h"
#import <UIKit/UIKit.h>


@interface MainViewPresenter: NSObject
-(instancetype) initWithImageNetworkFetcher: (ImageNetworkFetcher *)imageNetworkFetcher andView: (id<MainView>) view;

-(NSInteger)count;
-(NSData *)cellForItemAtIndexPath: (NSIndexPath *) indexPath;
-(void)didSelectItemAtIndexPath: (NSIndexPath *) indexPath;
-(void)didPullToRefresh;
-(void)preload;
@end


