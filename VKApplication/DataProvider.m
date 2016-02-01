//
//  DataProvider.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 22.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "DataProvider.h"
#import <AFNetworking/AFNetworking.h>

@implementation DataProvider

- (void)manager {
    self.theManager = [AFHTTPSessionManager manager];
}

- (void)showProgressOnView:(UIView *)view {
    if (!view) return;
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

- (void)hiddenProgressOnView:(UIView *)view {
    if (!view) return;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

- (id)fillObjectResponseWithDictionary:(NSDictionary *)dictionary {
    id obj = [self.theClass alloc];
    if ([obj respondsToSelector:@selector(initClassWithDictionary:)]) {
        obj = [obj initClassWithDictionary:dictionary];
    }
    return obj;
}

- (void)fillManagerURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    [self manager];
    self.theClass = classMapping;
    self.theParametrs = parameters;
    self.theUrlString = urlString;
    self.theView = view;
    self.responseBlock = response;
    self.failBlock = failure;

    [self showProgressOnView:view];
}


@end
