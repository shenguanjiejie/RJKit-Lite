//
//  UIViewController+RJInject.m
//  diling
//
//  Created by shenruijie on 2019/1/14.
//  Copyright © 2019 shenguanjiejie. All rights reserved.
//

#import "UIViewController+RJInject.h"

@implementation UIViewController (RJInject)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
        Method method2 = class_getInstanceMethod(self, @selector(rj_dealloc));
        method_exchangeImplementations(method1, method2);
        
        [self swizzleInstanceMethod:@selector(viewWillAppear:) with:@selector(rj_viewWillAppear:)];
        [self swizzleInstanceMethod:@selector(setTitle:) with:@selector(rj_setTitle:)];
    });
}

- (void)rj_dealloc{
    if (![self isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")]) {
        NSLog(@"💥💥💥💥💥💥💥💥💥💥💥%@", self);
    }
    [self rj_dealloc];
}

- (void)rj_setTitle:(NSString *)title{
    QMUINavigationTitleView *titleView = [self valueForKeyPath:@"self.navigationBarView.titleView"];
    titleView.title = title;
    [self rj_setTitle:title];
}

- (void)rj_viewWillAppear:(BOOL)animated{
    
    if (![self isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")]) {
        NSLog(@"👋👋👋👋👋👋👋👋👋👋👋%@",self);
        
#if debug
        NSArray<__kindof UIView *> *views = [[UIApplication sharedApplication].keyWindow subviews];
        [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIViewController *controller = [UIViewController topViewControllerWithoutModel];
                [(UIButton *)obj setTitle:NSStringFromClass([controller class]) forState:UIControlStateNormal];
                *stop = YES;
            }
        }];
#endif
    }
    
    [self rj_viewWillAppear:animated];
}

// A present B,A.presentedViewController = B,B.presentingViewController = A
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self topViewControllerWithoutModel];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+(UIViewController *)topViewControllerWithoutModel{
    return [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
}





@end
