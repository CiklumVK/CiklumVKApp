//
//  DataProvider.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 22.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataProvider : NSObject


@property NSDictionary *theParametrs;
@property NSString *theUrlString;
@property UIView *theView;
@property Class theClass;
@property AFHTTPSessionManager *theManager;

@property (copy, nonatomic) void (^responseBlock)(NSURLSessionDataTask * operation, id responseObject);
@property (copy, nonatomic) void (^failBlock)(NSURLSessionDataTask * operation, NSError * error);

- (id)fillObjectResponseWithDictionary:(NSDictionary *)dictionary;
- (void)fillManagerURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure;


@end
