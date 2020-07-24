//
//  UIViewController+BarButtonItem.h
//  duDu
//
//  Created by RuiJie on 16/11/15.
//  Copyright © 2016年 youd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BarButtonItem)

- (void)setBackBarButtonItemWithAction:(SEL)action;

- (void)setLeftBarButtonItemWithTitle:(NSString *)title action:(SEL)action;

- (void)setLeftBarButtonItemWithImageName:(NSString *)imageName action:(SEL)action;

- (void)setLeftBarButtonItemWithImageNames:(NSArray *)imageNames actions:(SEL)actions,...NS_REQUIRES_NIL_TERMINATION;

- (void)setRightBarButtonItemWithTitle:(NSString *)title action:(SEL)action;

- (void)setRightBarButtonItemWithImageName:(NSString *)imageName action:(SEL)action;

- (void)setRightBarButtonItemWithImageNames:(NSArray *)imageNames actions:(SEL)actions,...NS_REQUIRES_NIL_TERMINATION;

@end
