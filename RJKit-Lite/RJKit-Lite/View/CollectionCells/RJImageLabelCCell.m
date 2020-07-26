//
//  RJImageLabelCCell.m
//  diling
//
//  Created by shenruijie on 2018/7/23.
//  Copyright © 2018年 diling. All rights reserved.
//

#import "RJImageLabelCCell.h"
#import "RJKiteLitePch.h"
@implementation RJImageLabelCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.preservesSuperviewLayoutMargins = NO;
        self.contentView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _imageView = [self.contentView addImageViewWithImage:nil contentMode:UIViewContentModeScaleAspectFill];
        _titleLab = [self.contentView addLabelWithFont:kFontSize(12) textColor:kGrayColor text:nil];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        //        [_titleLab setContentHuggingPriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
        [_titleLab setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
        
        [_imageView addTopMarginConstraintWithConstant:0];
        [_imageView addHMarginConstraintWithLeftConstant:0 rightConstant:0];
        [_imageView addBottomConstraintToView:_titleLab constant:5];
        
        [_titleLab addHMarginConstraintWithLeftConstant:0 rightConstant:0];
        [_titleLab addBottomMarginConstraintWithConstant:0];
    }
    return self;
}


@end
