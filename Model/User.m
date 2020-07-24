//
//  User.m
//  diling
//
//  Created by shenruijie on 2018/12/18.
//  Copyright © 2018 shenguanjiejie. All rights reserved.
//

#import "User.h"

@implementation User

/**RJ 2020-05-09 18:29:05 //*/
//MJCodingImplementation


- (instancetype)init
{
    self = [super init];
    if (self) {
        /**RJ 2020-05-09 18:29:01 //*/
//        [self initAllProperties];
        self.signature = @"这个人很懒...";
    }
    return self;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userId":@"id",
             };
}

- (NSString *)userIdText{
    return kStringWithNum(self.userId);
}

- (NSString *)sexText{
    switch (self.sex) {
        case RJSexEnumNull:
            return @"未知";
        case RJSexEnumMale:
            return @"男";
        case RJSexEnumFemale:
            return @"女";
        case RJSexEnumGay:
            return @"男同";
        case RJSexEnumLesbian:
            return @"女同";
        default:
            return @"未知";
    }
}

- (NSString *)stateText{
    switch (self.state) {
        case RJUserStateHidden:
            return @"隐身";
        case RJUserStateOnline:
            return @"在线";
        default:
            return @"未知";
    }
}

- (NSString *)thirdSexText{
    switch (self.sex) {
        case RJSexEnumNull:
            return @"ta";
        case RJSexEnumMale:
        case RJSexEnumGay:
            return @"他";
        case RJSexEnumFemale:
        case RJSexEnumLesbian:
            return @"她";
        default:
            return @"ta";
    }
}

- (NSString *)locationStr{
    return [self.location componentsJoinedByString:@","];
}

- (CLLocation *)locationObj{
    if (_location.count < 2) {
        return nil;
    }
    return [[CLLocation alloc] initWithLatitude:[_location.lastObject doubleValue] longitude:[_location.firstObject doubleValue]];
}

/**RJ 2020-05-09 18:28:53 //*/
//- (NSString *)distance{
//    if (kUser.locationObj && self.locationObj) {
//        CGFloat m = [kUser.locationObj distanceFromLocation:self.locationObj];
//        return [Tools distanceStringWithDistance:m];
//    }
//
//    return nil;
//}

- (double)longitude{
    return [self.location.firstObject doubleValue];
}

- (double)latitude{
    return [self.location.lastObject doubleValue];
}
/**RJ 2019-01-22 19:02:31
 {
 "id": 5,
 "last_login": null,
 "is_superuser": false,
 "username": "test05",
 "first_name": "",
 "last_name": "",
 "is_staff": false,
 "is_active": true,
 "date_joined": "2018-12-10T20:24:30.888902",
 "name": "佚名",
 "birthday": null,
 "sex": "",
 "mobile": "test05",
 "email": null,
 "create_time": "2018-12-10T20:24:30.891473",
 "signature": "",
 "avatar": null,
 "bg_image": null,
 "location": [
 112,
 22
 ],
 "area": 3000,
 "groups": [],
 "user_permissions": []
 }
 */


@end
