//
//  RJChooseImageCell.h
//  diling
//
//  Created by shenruijie on 2018/1/25.
//  Copyright © 2018年 diling. All rights reserved.
//

#import "RJBaseCell.h"
#import "RJChooseImageView.h"


@interface RJChooseImageCell : RJBaseCell

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@property (nonatomic, strong) RJChooseImageView *imageVC;


@end
