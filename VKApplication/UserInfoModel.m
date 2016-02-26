//
//  UserInfoModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 08.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"firstName" : @"first_name",
             @"lastName" : @"last_name",
             @"onlineValue" : @"online",
             @"userID" : @"id",
             @"photo100" : @"photo_100",
             @"birthdayDate":@"bdate",
             @"cityInfo":@"city"
             };
}
@end
