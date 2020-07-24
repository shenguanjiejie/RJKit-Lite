//
//  SortItem.m
//  AppKing
//
//  Created by ShenRuijie on 2017/9/2.
//  Copyright © 2017年 shenruijie. All rights reserved.
//

#import "SortItem.h"

@implementation SortItem

/**RJ 2020-05-09 18:41:31 //*/
//MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selected = NO;
        _datas = [NSMutableArray array];
        _pageIndex = 1;
        _contentOffset = CGPointMake(0, 0);
    }
    return self;
}

@end
