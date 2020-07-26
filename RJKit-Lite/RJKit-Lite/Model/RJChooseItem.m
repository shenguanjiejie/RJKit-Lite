//
//  RJChooseItem.m
//  kisshappy
//
//  Created by shenruijie on 2017/10/27.
//  Copyright © 2017年 shenguanjiejie. All rights reserved.
//

#import "RJChooseItem.h"

@implementation RJChooseItem

- (instancetype)initWithID:(NSInteger)ID indexPath:(NSIndexPath *)indexPath key:(NSString *)key text:(NSString *)text state:(RJChooseItemState)state{
    self = [super init];
    if (self) {
        self.ID = ID;
        self.indexPath = indexPath;
        self.key = key;
        self.text = text;
        self.state = state;
    }
    return self;
}

- (instancetype)init{
    return [self initWithID:NSNotFound indexPath:nil key:nil text:nil state:RJChooseItemStateNone];
}


- (id)copyWithZone:(NSZone *)zone{
    RJChooseItem *item = [[[self class] allocWithZone:zone] init];
    item.ID = self.ID;
    item.indexPath = self.indexPath;
    item.key = self.key;
    item.text = self.text;
    item.state = self.state;
    item.image = self.image;
    item.otherState = self.otherState;
    return item;
}

- (BOOL)isSelected{
    if (self.state == RJChooseItemStateFilterAndSelected || self.state == RJChooseItemStateSelected) {
        return YES;
    }
    return NO;
}

@end
