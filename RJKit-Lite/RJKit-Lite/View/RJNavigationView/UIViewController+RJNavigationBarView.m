//
//  UIViewController+CustomNavigationBar.m
//  AppKing
//
//  Created by shenruijie on 17/5/11.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "UIViewController+RJNavigationBarView.h"
#import "RJKiteLitePch.h"
#import <objc/message.h>

static void const *NavigationBarViewKey = @"NavigationBarViewKey";
static void const *BackActionBlockKey = @"BackActionBlockKey";
static void const *rightBtnActionBlockKey = @"rightBtnActionBlockKey";
//static void const *rightBtnKey = @"rightBtnKey";
//static void const *backBtnKey = @"backBtnKey";

@implementation UIViewController (RJNavigationBarView)

- (void)setNavigationBarView:(RJNavigationBarView *)navigationBarView{
    objc_setAssociatedObject(self, NavigationBarViewKey, navigationBarView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(RJNavigationBarView *)navigationBarView{
    return objc_getAssociatedObject(self, NavigationBarViewKey);
}

- (void)setNav_backActionBlock:(void (^)(UIButton *backBtn))Nav_backActionBlock{
    objc_setAssociatedObject(self, BackActionBlockKey, Nav_backActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(UIButton *))Nav_backActionBlock{
    return objc_getAssociatedObject(self, BackActionBlockKey);
}

- (void)setNav_rightActionBlock:(void (^)(UIButton *rightBtn))Nav_rightActionBlock{
    objc_setAssociatedObject(self, rightBtnActionBlockKey, Nav_rightActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))Nav_rightActionBlock{
    return objc_getAssociatedObject(self, rightBtnActionBlockKey);
}
//
//- (void)setBackBtn:(UIButton *)backBtn{
//    objc_setAssociatedObject(self, backBtnKey, backBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIButton *)backBtn{
//    return objc_getAssociatedObject(self, backBtnKey);
//}
//
//- (void)setNav_rightBtn:(UIButton *)Nav_rightBtn{
//    objc_setAssociatedObject(self, rightBtnKey, Nav_rightBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIButton *)Nav_rightBtn{
//    return objc_getAssociatedObject(self, rightBtnKey);
//}

- (void)setNavigationBarView{
    self.navigationBarView = [[RJNavigationBarView alloc] init];
    self.navigationBarView.type = RJNavigationBarViewTypeBack;
    [self.view addSubview:self.navigationBarView];
    
    [self.view addHAlignConstraintToView:self.navigationBarView constant:0];
    [self.view addTopAlignConstraintToView:self.navigationBarView constant:0];
    
    [self.navigationBarView addHeightConstraintWithConstant:kSafeTop + 44];

}

- (void)setNavigationBarViewWithTitle:(NSString *)title{
    [self setNavigationBarView];
    self.navigationBarView.titleView.title = title;
}

- (void)setNavigationBarViewWithBackMsg:(NSString *)backMsg backSelector:(SEL)backSelector{
    [self setNavigationBarView];
    [self.navigationBarView addBackBtn];
    if (backMsg.length) {
        [self.navigationBarView.backBtn setTitle:[NSString stringWithFormat:@"%@",backMsg] forState:UIControlStateNormal];
    }
    if (backSelector) {
        [self.navigationBarView.backBtn addTarget:self action:backSelector forControlEvents:UIControlEventTouchUpInside];
    }

}

//- (void)setNavigationBarViewWithTitle:(NSString *)title backAction:(void (^)(UIButton *backBtn))backAction rightBtnAction:(void (^)(UIButton *rightBtn))rightBtnAction{
//    [self setNavigationBarViewWithTitle:title backAction:backAction];
//    [self setNav_rightBtn];
//    self.Nav_backActionBlock = rightBtnAction;
//    [self.Nav_rightBtn setTitle:rightMsg forState:UIControlStateNormal];
//    [self.Nav_rightBtn addTarget:self action:@selector(Nav_rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)setNavigationBarViewWithBackMsg:(NSString *)backMsg backSelector:(SEL)backSelector rightMsg:(NSString *)rightMsg rightBtnSelector:(SEL)rightBtnSelector{
    [self setNavigationBarViewWithBackMsg:backMsg backSelector:backSelector];
    [self.navigationBarView addRightBtn];
    [self.navigationBarView.rightBtn setTitle:rightMsg forState:UIControlStateNormal];
    if (rightBtnSelector) {
        [self.navigationBarView.rightBtn addTarget:self action:rightBtnSelector forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)Nav_backAction:(UIButton *)button{
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        if (self.Nav_backActionBlock) {
            self.Nav_backActionBlock(button);
        }
    });
}

- (void)Nav_rightBtnAction:(UIButton *)button{
    if (self.Nav_rightActionBlock) {
        self.Nav_rightActionBlock(button);
    }
}

- (void)setNavigationBackMsg:(NSString *)backMsg{
    if (self.navigationBarView.backBtn) {
        [self.navigationBarView setNavigationBackMsg:backMsg];
    }
}

- (void)setNavigationRightMsg:(NSString *)rightMsg{
    if (self.navigationBarView.rightBtn) {
        [self.navigationBarView setNavigationRightMsg:rightMsg];
    }
}

@end
