//
//  ViewController.m
//  CarouselTest
//
//  Created by Tawhid Joarder on 7/29/20.
//  Copyright © 2020 Brain Craft Ltd. All rights reserved.
//

#import "ViewController.h"
#import "ZoomAndSnapFlowLayout.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZoomAndSnapFlowLayout *flowLayout = [[ZoomAndSnapFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds
                                              collectionViewLayout:flowLayout];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds
//                                              collectionViewLayout:layout];
    
    
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.pagingEnabled = true;
    collectionView.bounces = true ;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView reloadData];
    [self.view addSubview:collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
       CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.greenColor;
    return cell;
}

@end
