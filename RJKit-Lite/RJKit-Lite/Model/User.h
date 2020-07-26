//
//  User.h
//  diling
//
//  Created by shenruijie on 2018/12/18.
//  Copyright © 2018 shenguanjiejie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
//#import "RJImage.h"

typedef NS_ENUM(NSUInteger, RJCountryEnum) {
    RJCountryEnumChina,
    RJCountryEnumUsa,
};

typedef NS_ENUM(NSUInteger, RJSexEnum) {
    RJSexEnumFemale,
    RJSexEnumMale,
    RJSexEnumNull,
    RJSexEnumLesbian,
    RJSexEnumGay,
};

typedef NS_ENUM(NSUInteger, RJUserState) {
    RJUserStateDeleted = -1,
    RJUserStateHidden = 0,
    RJUserStateOnline = 1,
};


@interface User : NSObject<NSCoding>

/**保存userId*/
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *userIdText;
/**保存用户手机号*/
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic , copy) NSString *name;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) RJCountryEnum country;
@property (nonatomic, copy) NSString *countryText;

@property (nonatomic, assign) RJSexEnum sex;
@property (nonatomic, copy) NSString *sexText;
@property (nonatomic, copy) NSString *thirdSexText;

/**保存用户头像*/
@property (nonatomic, copy) NSString *avatar;

/**保存用户photos*/
@property (nonatomic, strong) NSArray *imageUrls;

/**保存用户昵称*/
@property (nonatomic, copy) NSString *nickname;

/**RJ 2019-01-23 16:20:03 自我介绍*/
@property (nonatomic, copy) NSString *introduction;

/**保存用户登录密码*/
@property (nonatomic, copy) NSString *password;

/**保存城市名*/
@property (nonatomic, copy) NSString *cityName;

/**保存城市ID*/
@property (nonatomic, copy) NSString *cityId;

/**保存IP地址*/
@property (nonatomic, copy) NSString *ipAddress;

/**经度0-180*/
@property (nonatomic, assign) double longitude;

/**纬度0-90*/
@property (nonatomic, assign) double latitude;

/**保存Token值*/
@property (nonatomic, copy) NSString *token;

/**保存MemberCode值*/
@property (nonatomic, copy) NSString *userMemberCode;

@property (nonatomic , copy) NSArray<NSNumber *>              *location;
@property (nonatomic , strong) CLLocation *locationObj;
@property (nonatomic , copy) NSString *distance;
//@property (nonatomic , copy, readonly) NSString           *locationStr;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) BOOL              is_staff;
@property (nonatomic , copy) NSString              * last_login;
@property (nonatomic , copy) NSString              * last_name;
@property (nonatomic , copy) NSString              * signature;
@property (nonatomic , assign) BOOL              is_active;
@property (nonatomic , copy) NSString              * date_joined;
@property (nonatomic , copy) NSArray              * groups;
@property (nonatomic , assign) NSInteger              area;
@property (nonatomic , copy) NSArray             * user_permissions;
@property (nonatomic , copy) NSString              * bg_image;
@property (nonatomic , copy) NSString              * first_name;
@property (nonatomic , assign) BOOL              is_superuser;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * qq;

@property (nonatomic, assign) BOOL attention;
@property (nonatomic, assign) BOOL block;
@property (nonatomic, assign) BOOL black;
@property (nonatomic, assign) RJUserState state;
@property (nonatomic , copy) NSString              * stateText;



@end

