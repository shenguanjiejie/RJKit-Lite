//
//  UIViewController+CustomNavigationBar.h
//  AppKing
//
//  Created by shenruijie on 17/5/11.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJNavigationBarView.h"

@interface UIViewController (RJNavigationBarView)

/**
 *  BarView
 */
@property (nonatomic, strong) RJNavigationBarView *navigationBarView;

- (void)setNavigationRightBtn;

- (void)setNavigationBackMsg:(NSString *)backMsg;

- (void)setNavigationRightMsg:(NSString *)rightMsg;

- (void)setNavigationBarView;

/**
 *  一个只有标题的BarView
 *p
 *  @param title 标题
 */
- (void)setNavigationBarViewWithTitle:(NSString *)title;

/**
 *  一个有标题和返回按钮的BarView,selector形式
 *
 *  @param backMsg        标题
 *  @param backSelector 点击事件调用方法
 */
- (void)setNavigationBarViewWithBackMsg:(NSString *)backMsg backSelector:(SEL)backSelector;


/**
 *  一个有标题,返回按钮和右边按钮的BarView,右边按钮,selector形式
 *
 *  @param backMsg          标题
 *  @param backSelector     返回按钮点击事件调用方法
 *  @param rightBtnSelector 右边按钮点击事件调用方法
 */
- (void)setNavigationBarViewWithBackMsg:(NSString *)backMsg backSelector:(SEL)backSelector rightMsg:(NSString *)rightMsg rightBtnSelector:(SEL)rightBtnSelector;


@end
