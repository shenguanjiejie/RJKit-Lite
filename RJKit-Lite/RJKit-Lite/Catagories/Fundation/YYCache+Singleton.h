//
//  YYCache+Singleton.h
//  duDu
//
//  Created by RuiJie on 16/12/15.
//  Copyright © 2016年 RuiJie. All rights reserved.
//

#import <YYCache/YYCache.h>
#import "User.h"
//#import "ServerInfo.h"
#import "NotificationInfo.h"

#define YYCacheInstance [YYCache sharedCache]
#define kUser YYCacheInstance.user
#define kServerInfo YYCacheInstance.serverInfo

#define kCachePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"MainCache"]

//伪单例
@interface YYCache (Singleton)


@property (nonatomic, strong) User *user;
//@property (nonatomic, strong) ServerInfo *serverInfo;

@property (nonatomic, strong) NSArray<User *> *friends;

/**
 *  YYCache单例实现
 */
+(YYCache *)sharedCache;


User *user(void);

BOOL containsUser(void);
User *diskUser(void);
void cacheUser(User *);

//ServerInfo *diskServerInfo(void);
//void cacheServerInfo(ServerInfo *);


@end
    
