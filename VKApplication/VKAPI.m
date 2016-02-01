    //
//  VKAPI.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 22.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "VKAPI.h"
#import "FriendsObject.h"
#import "NSString+Extension.h"


@interface VKAPI ()

@end



@implementation VKAPI

- (void)getFriendListWithResponse:(void (^)(id))response fail:(void (^)(NSError *))failure{
    [[NetworkManager sharedInstance]GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@",friendsGetPath, [LogIn accessToken]] classMapping:[FriendsObject class] showProgressOnView:nil response:^(NSURLSessionDataTask *operation, id responseObject) {
        response(responseObject);
    } fail:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error);
        NSLog(@"%@", error.description);
    } ];
}

- (void)makeSearchWithText:(NSString *)searchText response:(void (^)(id))response fail:(void (^)(NSError *))failure{
    [[NetworkManager sharedInstance]GETConnectionWithURLString:[NSString encodeLink:searchText] classMapping:[FriendsObject class] showProgressOnView:nil response:^(NSURLSessionDataTask *operation, id responseObject) {
        response(responseObject);
    } fail:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error);
        NSLog(@"%@", error.description);
    }];
}

@end
