//
//  ViewController.h
//  DromTest
//
//  Created by Victor on 04/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewPresenter.h"
#import "MainView.h"

@interface MainViewController: UIViewController<MainView>
@property (strong, nonatomic) MainViewPresenter *presenter;
@end

