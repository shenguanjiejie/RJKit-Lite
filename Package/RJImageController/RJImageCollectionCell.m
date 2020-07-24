//
//  RJImageCollectionCell.m
//  diling
//
//  Created by ShenRuijie on 2017/7/1.
//  Copyright © 2017年 diling. All rights reserved.
//

#import "RJImageCollectionCell.h"

@implementation RJImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _deleteBtn = [[UIButton alloc]init];
        _deleteBtn.translatesAutoresizingMaskIntoConstraints = NO;
        _deleteBtn.backgroundColor = [UIColor clearColor];
        _deleteBtn.adjustsImageWhenHighlighted = NO;
        _deleteBtn.hidden = YES;
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_deleteBtn setImage:kImageNamed(remove) forState:UIControlStateNormal];
        [self.contentView addSubview:_deleteBtn];
        
        _tipLab = [self.contentView addLabelWithFont:kFontSize(10) textColor:[UIColor whiteColor] text:kLocalString(default)];
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.backgroundColor = [kGrayColor colorWithAlphaComponent:0.7];
        _tipLab.hidden = YES;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_deleteBtn);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_deleteBtn(25)]" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_deleteBtn(25)]" options:0 metrics:nil views:views]];
        
        [self.contentView addBottomAlignConstraintToView:_tipLab constant:0];
        [self.contentView addRightAlignConstraintToView:_tipLab constant:10];
        [_tipLab addWidthConstraintWithConstant:30 heightConstraintWithConstant:16];
    }
    return self;
}




@end
