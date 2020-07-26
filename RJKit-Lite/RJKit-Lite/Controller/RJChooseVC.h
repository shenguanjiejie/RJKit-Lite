//
//  RJChooseVC.h
//  deyue
//
//  Created by ShenRuijie on 2017/6/20.
//  Copyright © 2017年 mikeshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJChooseItem.h"

@interface RJChooseVC : UIViewController

typedef void (^RJChooseCompletionBlock)(RJChooseVC *chooseVC,NSArray<RJChooseItem *> *selects);
/**
 是否允许多选,默认NO
 */
@property (nonatomic, assign) BOOL shouldMultiSelect;
/**
 是否允许手动输入一项,默认NO
 */
@property (nonatomic, assign) BOOL shouldAdd;

/**shenruijie 2018-03-12 18:28:57 是否自动返回 默认YES*/
@property (nonatomic, assign) BOOL autoBack;

/**RJ 2019-09-27 15:49:14 default:44*/
//@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;


/**
 背景色
 */
@property (nonatomic, strong) UIColor *backgroundColor;
/**
 列表数据
 */
@property (nonatomic, strong) NSArray<RJChooseItem *> *data;
/**
 被选中的数据
 */
@property (nonatomic, strong, readonly) NSMutableArray<RJChooseItem *> *selects;

@property (nonatomic, copy) dispatch_block_t viewDidLoadBlock;


- (instancetype)initWithCompletion:(RJChooseCompletionBlock)completion;

@end
