//
//  RJButtonCCell.m
//  kisshappy
//
//  Created by shenruijie on 2017/10/27.
//  Copyright © 2017年 shenguanjiejie. All rights reserved.
//

#import "RJButtonCCell.h"
#import "UIView+RJVFL.h"
#import "RJKitLitePch.h"
@implementation RJButtonCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.layoutMargins = UIEdgeInsetsMake(2, 5, 2, 5);
        self.contentView.preservesSuperviewLayoutMargins = NO;
        UIView *view = [[UIView alloc] init];
        [self setSelectedBackgroundView:view];
        
        _button = [[UIButton alloc]init];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.backgroundColor = [UIColor clearColor];
        _button.titleLabel.font = kFontSize(12.5);
        _button.adjustsImageWhenHighlighted = NO;
        [_button setTitleColor:kBlackColor forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        
        [_button addMarginsConstraintWithEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        _tipImageView = [self.contentView addImageViewWithImage:kImageNamed(home_white_point) contentMode:UIViewContentModeScaleAspectFit];
        _tipImageView.hidden=  YES;
        [self.contentView addRightAlignConstraintToView:_tipImageView constant:20];
        [self.contentView addTopAlignConstraintToView:_tipImageView constant:32];
        [_tipImageView addWidthConstraintWithConstant:6 heightConstraintWithConstant:6];
    }
    return self;
}

@end
