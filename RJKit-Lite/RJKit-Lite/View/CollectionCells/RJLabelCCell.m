//
//  RJLabelCCell.m
//  AppKing
//
//  Created by shenruijie on 2017/11/22.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "RJLabelCCell.h"
#import "RJKitLitePch.h"
@implementation RJLabelCCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layoutMargins = UIEdgeInsetsMake(0, 0, 0.5, 0);
        self.contentView.preservesSuperviewLayoutMargins = NO;
        self.contentView.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.layer.masksToBounds = YES;
        _titleLab.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLab.font = kFontSize(14);
        _titleLab.textColor = kBlackColor;
        _titleLab.numberOfLines = 0;
        _titleLab.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_titleLab];
        
        _lineView = [[UIView alloc]init];
        _lineView.hidden = YES;
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
        _lineView.backgroundColor = kSeparateColor;
        [self.contentView addSubview:_lineView];
        
        
        [self rj_setConstraints];
    }
    return self;
}

-(void)rj_setConstraints{
    [self.contentView addAllAlignConstraintToView:_titleLab constant:0];
    
    [_lineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_lineView addHeightConstraintWithConstant:0.5];
    [_lineView addLeftMarginConstraintWithConstant:0];
    [_lineView addRightMarginConstraintWithConstant:0];
}
@end
