//
//  ImageCell.h
//  DromTest
//
//  Created by Victor on 05/10/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageCellIdentifier @"ImageCellIdentifier"

@interface ImageCell : UICollectionViewCell
-(void)setImageData: (NSData *) imageData;
@end

