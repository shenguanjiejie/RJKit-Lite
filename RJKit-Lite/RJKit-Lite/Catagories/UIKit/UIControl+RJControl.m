//
//  UIControl+RJControl.m
//  diling
//
//  Created by shenruijie on 2018/9/17.
//  Copyright © 2018年 diling. All rights reserved.
//

#import "UIControl+RJControl.h"
#import "QMUILab.h"
#import "RJKitLitePch.h"
@implementation UIControl (RJControl)

QMUISynthesizeBOOLProperty(rj_ban, setRj_ban)

- (BOOL)rj_beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    BOOL b = [self rj_beginTrackingWithTouch:touch withEvent:event];
    
    if (touch.window != [UIApplication sharedApplication].keyWindow) {
        return b;
    }
    /**RJ 2019-09-12 09:52:29
     !(BOOL)class_getProperty([self class], [@"inputView" UTF8String]) 如果下个事件仍是输入框,则不降下键盘
     ![self.superview isFirstResponder] 为了防止textField清除按钮丢失firstResponder
     UICalloutBarButton 是选中文本后跳出的copy/paste等按钮
     */
    
    if (![self respondsToSelector:@selector(setInputView:)] && !self.isFirstResponder && ![self.superview isFirstResponder] && ![NSStringFromClass([self class]) isEqualToString:@"UICalloutBarButton"] && !self.rj_ban && ![NSStringFromClass([self class]) isEqualToString:@"UIKeyboardDockItemButton"]) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    
    return b;
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIControl swizzleInstanceMethod:@selector(beginTrackingWithTouch:withEvent:) with:@selector(rj_beginTrackingWithTouch:withEvent:)];
    });
}


@end
