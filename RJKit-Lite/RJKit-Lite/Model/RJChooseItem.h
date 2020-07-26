//
//  RJChooseItem.h
//  kisshappy
//
//  Created by shenruijie on 2017/10/27.
//  Copyright © 2017年 shenguanjiejie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJKitLitePch.h"

typedef NS_ENUM(NSUInteger, RJChooseItemState) {
    RJChooseItemStateNone,
    /**当前用作筛选的*/
    RJChooseItemStateFilterAndSelected,
    /**用作筛选的,但是不在选中状态的*/
    RJChooseItemStateFilter,
    /**被选中的*/
    RJChooseItemStateSelected,
    /**不可选择,灰色*/
    RJChooseItemStateDisable,
    /**忽略该item,不进行显示*/
    RJChooseItemStateValid,
};


@interface RJChooseItem : NSObject<NSCopying>

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) RJChooseItemState state;

@property (nonatomic, strong) id data;


@property (nonatomic, assign, readonly) BOOL isSelected;
//
///**valid为NO,则对象项为无效对象,不会显示*/
//@property (nonatomic, assign,getter=isValid) BOOL valid;
//
///**enable为NO,则该对象不可被选中*/
//@property (nonatomic, assign,getter=isEnable) BOOL enable;

/**其他状态,根据自己情况使用*/
@property (nonatomic, assign) NSInteger otherState;

/**扩展以兼容带有图片的model*/
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSArray<RJChooseItem *> *childItems;


- (instancetype)initWithID:(NSInteger)ID indexPath:(NSIndexPath *)indexPath key:(NSString *)key text:(NSString *)text state:(RJChooseItemState)state;

@end
