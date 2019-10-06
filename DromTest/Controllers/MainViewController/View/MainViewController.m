//
//  ViewController.m
//  DromTest
//
//  Created by Victor on 04/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewPresenter.h"
#import "ImageCell.h"
#import "MainViewFlowLayout.h"

@interface MainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


- (void)setup;
@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView layoutIfNeeded];
    [self.collectionView reloadData];
}

@end

#pragma mark -ViewConfiguration
@implementation MainViewController (View)

- (void)setup {
    self.title = @"TEST";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupCollectionView];
    [self addRefreshControl];
    [_presenter preload];
}

- (void)setupCollectionView {
    MainViewFlowLayout* flowLayout = [[MainViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:kImageCellIdentifier];
    [self addCollectionViewCostraints];
}

- (void)addCollectionViewCostraints {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [NSLayoutConstraint activateConstraints:@[top, left, right, bottom]];
}

- (void)addRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.collectionView.refreshControl = self.refreshControl;
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)refresh: (UIRefreshControl *) sender {
    [sender beginRefreshing];
    [_presenter didPullToRefresh];
}

@end

#pragma mark -UICollectionViewDelegate and flow layout
@implementation MainViewController (UICollectionViewDelegate)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_presenter didSelectItemAtIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width - 20;
    return CGSizeMake(width, width);
}

@end

#pragma mark -UICollectionViewDataSource
@implementation MainViewController (UICollectionViewDataSource)

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kImageCellIdentifier forIndexPath:indexPath];
    [cell setImageData:[_presenter cellForItemAtIndexPath:indexPath]];
    
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_presenter count];
}

@end

#pragma mark -Events
@implementation MainViewController (Events)
- (void)imageDataDidLoad:(NSData *)imageData atIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        MainViewController * __weak weakSelf = self;
        [weakSelf.collectionView reloadData];
        [(ImageCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath] setImageData:imageData];
    });
}

- (void)removedImageAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView deleteItemsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil]];
}

- (void)updateCollectionView {
    [self.collectionView performBatchUpdates:^{
        MainViewController *__weak weakSelf = self;
        [weakSelf.collectionView reloadData];
    } completion:nil];
}

- (void)didRefresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        MainViewController * __weak weakSelf = self;
        [weakSelf.collectionView.refreshControl endRefreshing];
    });
}
@end

