//
//  NotificationInfo.h
//  diling
//
//  Created by shenruijie on 2019/1/27.
//  Copyright © 2019 shenguanjiejie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RJObjectStatus) {
    RJObjectStatusCreate,
    RJObjectStatusUpdate,
    /**RJ 2019-10-08 16:42:43 转移*/
    RJObjectStatusMove,
    /**RJ 2019-10-08 16:42:43 使生效*/
    RJObjectStatusEnable,
    /**RJ 2019-10-08 16:42:43 使失效*/
    RJObjectStatusDisable,
    RJObjectStatusDelete,
    RJObjectStatusOther,
};

NS_ASSUME_NONNULL_BEGIN

@interface NotificationInfo : NSObject

@property (nonatomic, assign) RJObjectStatus status;

@property (nonatomic, strong) id object;


@end

NS_ASSUME_NONNULL_END
