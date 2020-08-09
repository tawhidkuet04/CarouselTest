//
//  ViewController.m
//  CarouselTest
//
//  Created by Tawhid Joarder on 7/29/20.
//  Copyright © 2020 Brain Craft Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "SCAdCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SCCollectionViewFlowLayoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCAdCollectionViewLayout *layout = [[SCAdCollectionViewLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(122, 217);
    layout.minimumLineSpacing = 42.5;
    layout.minimumInteritemSpacing = 0.0;
    layout.secondaryItemMinAlpha = 1;
    layout.threeDimensionalScale = 1.15;
    layout.delegate = self ;
    layout.cycleIndex = 1;
    CGFloat x_inset =(self.view.frame.size.width-layout.itemSize.width) / 2.f;
    layout.sectionInset = UIEdgeInsetsMake(0, x_inset, 0, x_inset);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 120, UIScreen.mainScreen.bounds.size.width, 400)
                                            collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.blueColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = 0 ;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView reloadData];
    [self.view addSubview:self.collectionView];
    
}
- (void)sc_collectioViewScrollToIndex:(NSInteger)index{
    NSLog(@"index %ld",(long)index);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.greenColor;
    return cell;
}
- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    return NO;
}

@end
