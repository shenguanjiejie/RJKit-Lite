//
//  UIViewController+UIAlertController.h
//  innerCloud
//
//  Created by Ruijie on 2017/3/29.
//  Copyright © 2017年 Ruijie. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TYAlertController.h>

@interface UIViewController (RJAlert)

#pragma mark - alert

/**
 只有"确定"按钮
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;

/**
 有一个"取消"按钮,confirmTitle文字自定义
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;

/**
 cancelTitle和confirmTitle都自定义
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(UIAlertAction *confirmAction))cancelBlock confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;


//- (RMessageView *)showRMessageViewWithTitle:(NSString *)title;

/**RJ 2020-05-09 18:26:49 //*/
//- (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<TYAlertAction *> *)actions;

- (void)showSheetWithTitle:(NSString *)title message:(NSString *)message otherActions:(NSArray<UIAlertAction *> *)otherActions;

- (void)showSheetWithTitle:(NSString *)title message:(NSString *)message ancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)(UIAlertAction *confirmAction))cancelBlock otherActions:(NSArray<UIAlertAction *> *)otherActions;


@end
