//
//  NetworkManager.h
//  VKApp
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD.h>

//extern const struct APIPaths
//{
//    __unsafe_unretained NSString *login;
//} APIPaths;


@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(NSURLSessionDataTask *operation, id responseObject))response fail:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(NSURLSessionDataTask *operation, id responseObject))response fail:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


@end
