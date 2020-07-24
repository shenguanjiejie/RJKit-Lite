//
//  SortItem.h
//  AppKing
//
//  Created by ShenRuijie on 2017/9/2.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RJPage.h"

@interface SortItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, assign) NSInteger  pageIndex;

@property (nonatomic, assign) CGPoint contentOffset;

@property (nonatomic, strong) NSMutableArray *datas;

//@property (nonatomic, strong) PageModel *pageModel;


@end
