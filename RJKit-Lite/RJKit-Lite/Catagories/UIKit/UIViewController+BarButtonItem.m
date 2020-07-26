//
//  UIViewController+BarButtonItem.m
//  duDu
//
//  Created by RuiJie on 16/11/15.
//  Copyright © 2016年 youd. All rights reserved.
//

#import "UIViewController+BarButtonItem.h"

@interface UIViewController ()<UIGestureRecognizerDelegate>

@end

@implementation UIViewController (BarButtonItem)

- (void)setBackBarButtonItemWithAction:(SEL)action{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
}

- (void)setLeftBarButtonItemWithTitle:(NSString *)title action:(SEL)action{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
}

- (void)setLeftBarButtonItemWithImageName:(NSString *)imageName action:(SEL)action{
    UIImage *image = [UIImage imageNamed:imageName];
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = imageItem;
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
}

- (void)setLeftBarButtonItemWithImageNames:(NSArray *)imageNames actions:(SEL)actions, ...{
    self.navigationItem.leftBarButtonItems = [self barButtonItemsWithImageNames:imageNames actions:actions];
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
}

- (void)setRightBarButtonItemWithTitle:(NSString *)title action:(SEL)action{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setRightBarButtonItemWithImageName:(NSString *)imageName action:(SEL)action{
    UIImage *image = [UIImage imageNamed:imageName];
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = imageItem;
}

- (void)setRightBarButtonItemWithImageNames:(NSArray *)imageNames actions:(SEL)actions, ...{
    self.navigationItem.rightBarButtonItems = [self barButtonItemsWithImageNames:imageNames actions:actions];
}

- (NSArray *)barButtonItemsWithImageNames:(NSArray *)imageNames actions:(SEL)actions, ...{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    va_list args;
    va_start(args, actions);
    if (actions)
    {
        int i = 0;
        SEL action = NULL;
        while (action == va_arg(args, SEL))
        {
            //依次取得所有参数
            UIImage *image = [UIImage imageNamed:imageNames[i]];
            UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
            [arr addObject:imageItem];
            i++;
        }
    }
    va_end(args);
    
    return arr;
}


@end
