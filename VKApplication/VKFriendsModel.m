//
//  VKFriendsModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 02.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "VKFriendsModel.h"

@implementation VKFriendsModel


+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"firstName" : @"first_name",
             @"userID" : @"id",
             @"onlineValue" : @"online",
             @"lastName" : @"last_name",
             @"photo100" : @"photo_100",
             @"sexFriend":@"sex"};
}


@end
