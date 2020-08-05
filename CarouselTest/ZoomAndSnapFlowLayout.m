//
//  ZoomAndSnapFlowLayout.m
//  CarouselTest
//
//  Created by Tawhid Joarder on 7/29/20.
//  Copyright © 2020 Brain Craft Ltd. All rights reserved.
//

#import "ZoomAndSnapFlowLayout.h"

int activeDistance = 200;
int zoomFactor = 0.3;

@implementation ZoomAndSnapFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 40;
        self.itemSize = CGSizeMake(150, 150);
    }
    return self;
}

- (void)prepareLayout{
    float verticalInsets = (self.collectionView.frame.size.height - self.collectionView.adjustedContentInset.top - self.collectionView.adjustedContentInset.bottom - self.itemSize.height) / 2;
    float horizontalInsets = (self.collectionView.frame.size.width - self.collectionView.adjustedContentInset.right - self.collectionView.adjustedContentInset.left - self.itemSize.width) / 2;
    self.sectionInset = UIEdgeInsetsMake(verticalInsets, horizontalInsets, verticalInsets, horizontalInsets);
    [super prepareLayout];
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray<UICollectionViewLayoutAttributes *> *rectAttributes = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    for( UICollectionViewLayoutAttributes *attributes in rectAttributes){
        if(CGRectIntersectsRect(attributes.frame, visibleRect)){
            float distance = visibleRect.size.width/2 - attributes.center.x;
            float normalizedDistance = distance / activeDistance;
            if(fabsf(distance) < activeDistance){
              NSLog(@"layoutAttributesForElementsInRect %f",fabs(normalizedDistance));
                float zoom = 1 + zoomFactor * ( 1 - fabsf(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1);
                attributes.zIndex = (int)zoom;
            }
        }
    }
    return rectAttributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
    NSArray<UICollectionViewLayoutAttributes *> *rectAttributes = [super layoutAttributesForElementsInRect:targetRect];
    
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    float  horizontalCenter = proposedContentOffset.x + self.collectionView.frame.size.width / 2 ;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in rectAttributes ){
        float itemHorizontalCenter = layoutAttributes.center.x;
        if (fabsf((itemHorizontalCenter - horizontalCenter)) < fabsf(offsetAdjustment)){
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return  CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return  true ;
}
- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds{
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForBoundsChange:newBounds];
    return context;
    
}
@end
