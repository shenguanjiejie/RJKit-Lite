//
//  ProgressNavigationBarView.h
//  kisshappy
//
//  Created by ShenRuijie on 2017/11/12.
//  Copyright © 2017年 shenguanjiejie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMUINavigationTitleView.h>
typedef NS_ENUM(NSUInteger, RJNavigationBarViewType) {
    RJNavigationBarViewTypeBack = 1,
    RJNavigationBarViewTypeClose = 1 << 1,
    RJNavigationBarViewTypeProgress = RJNavigationBarViewTypeBack | RJNavigationBarViewTypeClose + 1,
};



@interface RJNavigationBarView : UIView

@property (nonatomic, assign) RJNavigationBarViewType type;

@property (nonatomic, assign) NSInteger currentStep;

@property (nonatomic, assign) NSInteger totalStep;

@property (nonatomic, strong) QMUINavigationTitleView *titleView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *imageView;


/**
 *  左边按钮
 */
@property (nonatomic, strong) UIButton *backBtn;

/**
 *  右边按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;



- (void)addBackBtn;

- (void)addRightBtn;


- (void)setNavigationBackMsg:(NSString *)backMsg;

- (void)setNavigationRightMsg:(NSString *)rightMsg;



@end
