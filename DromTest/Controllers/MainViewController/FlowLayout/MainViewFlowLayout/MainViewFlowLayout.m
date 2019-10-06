//
//  MainViewFlowLayout.m
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewFlowLayout.h"


@implementation MainViewFlowLayout
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes * attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    attributes.transform = CGAffineTransformMakeTranslation(self.collectionViewContentSize.width, 0);
    
    return attributes;
}

@end
