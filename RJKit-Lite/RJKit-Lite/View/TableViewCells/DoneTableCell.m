//
//  DoneTableCell.m
//  AppKing
//
//  Created by ShenRuijie on 2017/7/17.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "DoneTableCell.h"

#import "RJKitLitePch.h"
@implementation DoneTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _doneBtn = [[UIButton alloc]init];
        _doneBtn.translatesAutoresizingMaskIntoConstraints = NO;
        _doneBtn.layer.cornerRadius = 5;
        _doneBtn.backgroundColor = kGreenColor;
        _doneBtn.titleLabel.font = kFontSize(16);
        _doneBtn.adjustsImageWhenHighlighted = NO;
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self.contentView addSubview:_doneBtn];
        
        [self.contentView addHAlignConstraintToView:_doneBtn constant:30];
        [_doneBtn addHeightConstraintWithConstant:44];
        [self.contentView addTopAlignConstraintToView:_doneBtn constant:30];
    }
    
    return self;
}

@end
