//
//  AppDelegate.m
//  DromTest
//
//  Created by Victor on 04/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupWindowAndController];
    return YES;
}

- (void)setupWindowAndController {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    MainViewController *controller = [[MainViewController alloc] init];
    MainViewPresenter *presenter = [[MainViewPresenter alloc] initWithImageNetworkFetcher:[[ImageNetworkFetcher alloc] init] andView:controller];
    controller.presenter = presenter;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.window makeKeyAndVisible];
}


@end
