//
//  RJCodeCell.m
//  diling
//
//  Created by shenruijie on 2019/1/17.
//  Copyright © 2019 shenguanjiejie. All rights reserved.
//

#import "RJCodeCell.h"
#import "UITextField+RJInputLimit.h"
#import "RJKiteLitePch.h"

@implementation RJCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//        self.contentView.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 15);
        
        _textField = [self.contentView addTextFieldWithFont:kSystemFontSize(16) textColor:kBlackColor text:nil keybordType:UIKeyboardTypeNumberPad];
        _textField.placeholder = @"请输入验证码";
        _textField.rj_maxLength = 6;
        
        _button = [self.contentView addButtonWithFont:kSystemFontSize(13) title:@"获取验证码" titleColor:[UIColor whiteColor] image:nil];
        _button.backgroundColor = kLightGrayColor;
        _button.layer.cornerRadius = 3;
        _button.userInteractionEnabled = NO;
        
        [_textField addLeftMarginConstraintWithConstant:5];
        [_button addRightMarginConstraintWithConstant:0];
        [self.contentView addVAlignConstraintToView:_textField constant:0];
        [_textField addCenterYConstraintToView:_button constant:0];
        [_button addHeightConstraintWithConstant:30];
        [_textField addRightConstraintToView:_button constant:5];
        [_button addWidthConstraintWithConstant:80];
    }
    return self;
}

@end
