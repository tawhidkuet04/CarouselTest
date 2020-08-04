//
//  ZoomAndSnapFlowLayout.h
//  CarouselTest
//
//  Created by Tawhid Joarder on 7/29/20.
//  Copyright © 2020 Brain Craft Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZoomAndSnapFlowLayout : UICollectionViewFlowLayout
@property (nonatomic) CGFloat activeDistance;
@property (nonatomic) CGFloat zoomFactor;
@end

NS_ASSUME_NONNULL_END
