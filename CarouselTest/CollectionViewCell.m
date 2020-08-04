//
//  CollectionViewCell.m
//  CarouselTest
//
//  Created by Tawhid Joarder on 7/30/20.
//  Copyright © 2020 Brain Craft Ltd. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentView.backgroundColor = UIColor.greenColor;
    }
    return self;
}

@end
