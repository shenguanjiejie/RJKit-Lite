//
//  UITextField+JKInputLimit.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 2016/11/29.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, TextFieldTextTypeValidate) {
//    TextFieldTextTypeValidate_Number = 1 << 0,
//    TextFieldTextTypeValidate_Letter = 1 << 1,
//    TextFieldTextTypeValidate_Special = 1 << 2,
//    TextFieldTextTypeValidate_Emoji = 1 << 3,
//    TextFieldTextTypeValidate_NotEmoji = TextFieldTextTypeValidate_Number | TextFieldTextTypeValidate_Letter | TextFieldTextTypeValidate_Special,
//};

@interface UITextField (JKInputLimit)
@property (assign, nonatomic)  NSInteger jk_maxLength;//if <=0, no limit

//@property (nonatomic, assign) TextFieldTextTypeValidate textFieldTextTypeValidate;

@end
