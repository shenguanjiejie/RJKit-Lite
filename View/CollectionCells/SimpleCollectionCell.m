//
//  SimpleCollectionCell.m
//  duDu
//
//  Created by w on 16/7/11.
//  Copyright © 2016年 youd. All rights reserved.
//

#import "SimpleCollectionCell.h"

@implementation SimpleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        CGFloat imageHW = 35;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - imageHW) / 2.0, (frame.size.height - imageHW) / 2.0 / 2.0, imageHW,imageHW)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom, frame.size.width, 20)];
        _titleLab.textColor = [UIColor lightGrayColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLab];
    }
    return self;
}

@end
