//
//  VKAPI.h
//  VKApp
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD.h>

@interface VKAPI : NSObject

+ (instancetype)sharedInstance;

- (void)setParameters:(NSDictionary *)dictionary;

- (void)setURLString:(NSString *)urlString;

- (void)setView:(UIView *)view;

- (void)setClass:(Class)theClass;

- (void)setResponseBlock:(void (^)(NSURLSessionDataTask *, id))responseBlock;

- (void)setFailBlock:(void (^)(NSURLSessionDataTask *, NSError *))failBlock;

- (void)requestSerializer;

- (void)connectionStartPOST;
- (void)connectionStartGET;
- (void)connectionStartPUT;


- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view serializer:(BOOL)serializer response:(void (^)(NSURLSessionDataTask *operation, id responseObject))response fail:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view serializer:(BOOL)serializer response:(void (^)(NSURLSessionDataTask *operation, id responseObject))response fail:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (void)PUTConnectionWithURLString:(NSString *)urlString classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view serializer:(BOOL)serializer response:(void (^)(NSURLSessionDataTask *operation, id responseObject))response fail:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


@end
