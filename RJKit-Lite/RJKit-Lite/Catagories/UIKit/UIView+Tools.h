//
//  UIView+Tools.h
//  AppKing
//
//  Created by ShenRuijie on 2017/7/19.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tools)

- (UIButton *)addImageButtonWithImage:(id)image;
- (UIButton *)addButtonWithFont:(UIFont *)font title:(NSString *)title titleColor:(UIColor *)titleColor image:(id)image;

- (UIView *)addViewWithBackgroundColor:(UIColor *)backgroundColor;

- (UIImageView *)addImageViewWithImage:(id)image contentMode:(UIViewContentMode)contentMode;

- (UILabel *)addLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text;

- (UITextField *)addTextFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text keybordType:(UIKeyboardType)keyboardType;
- (UITextView *)addTextViewWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text placeholder:(NSString *)placehodler;

- (UIView *)addBottomLine;

- (UIView *)addTopLine;

- (UIImageView *)addRightArrow:(UIImage *)image;

/*
 ** lineFrame:     虚线的 frame
 ** length:        虚线中短线的宽度
 ** spacing:       虚线中短线之间的间距
 ** color:         虚线中短线的颜色
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame lineLength:(int)length lineSpacing:(int)spacing lineColor:(UIColor *)color;

//调用该类方法即可获得当前第一响应者
+ (id)rj_currentFirstResponder;

@end
