//
//  VKAPI.m
//  VKApp
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "VKAPI.h"


@implementation VKAPI{
    NSDictionary *_parameters;
    NSString *_urlString;
    UIView *_view;
    Class _class;
    
    AFHTTPSessionManager *_manager;
    void (^_responseBlock)(NSURLSessionDataTask * operation, id responseObject);
    void (^_failBlock)(NSURLSessionDataTask * operation, NSError * error);
}

+ (instancetype)sharedInstance {
    static VKAPI *_api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _api = [[VKAPI alloc] init];
    });
    return _api;
}

- (void)manager {
    _manager = [AFHTTPSessionManager manager];
}

- (void)setParameters:(NSDictionary *)dictionary {
    _parameters = dictionary;
}

- (void)setURLString:(NSString *)urlString {
    _urlString = urlString;
}

- (void)setView:(UIView *)view {
    _view = view;
}

- (void)setClass:(Class)theClass {
    _class = theClass;
}

- (void)setResponseBlock:(void (^)(NSURLSessionDataTask *, id))responseBlock {
    _responseBlock = responseBlock;
}

- (void)setFailBlock:(void (^)(NSURLSessionDataTask *, NSError *))failBlock {
    _failBlock = failBlock;
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
//    id obj = [_class alloc];
//    if ([obj respondsToSelector:@selector(initClassWithDictionary:)]) {
//        obj = [obj initClassWithDictionary:dictionary];
//    }
    id obj;
    return obj;
}

- (void)fillManagerURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    [self manager];
    
    [self setURLString:urlString];
    [self setParameters:parameters];
    [self setClass:classMapping];
    [self setView:view];
    [self setResponseBlock:response];
    [self setFailBlock:failure];
    // [self setConstructingBody:block];
    
    
    [self showProgressOnView:view];
}
//- (void)requestSerializer {
//    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [_manager.requestSerializer setValue:[SPAuthorization userID] forHTTPHeaderField:@"userId"];
//    [_manager.requestSerializer setValue:[SPAuthorization sessionHash] forHTTPHeaderField:@"usersessionhash"];
//}


- (void)connectionStartPOST {
    [_manager POST:_urlString parameters:_parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hiddenProgressOnView:_view];
        _responseBlock(task, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenProgressOnView:_view];
        _failBlock(task, error);
        
    }];
}

- (void)connectionStartGET {
    [_manager GET:_urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hiddenProgressOnView:_view];
        _responseBlock(task, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenProgressOnView:_view];
        _failBlock(task, error);
    }];
}

- (void)connectionStartPUT {
    [_manager PUT:_urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hiddenProgressOnView:_view];
        _responseBlock(task, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hiddenProgressOnView:_view];
        _failBlock(task, error);
    }];
    
}
- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view serializer:(BOOL)serializer response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    [self fillManagerURLString:urlString parameters:parameters classMapping:classMapping showProgressOnView:view response:response fail:failure constructingBodyWithBlock:nil];
    
//    if (serializer) {
//        [self requestSerializer];
//    }
    
    [self connectionStartPOST];
}
- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view serializer:(BOOL)serializer response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    [self fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view response:response fail:failure constructingBodyWithBlock:nil];
    
//    if (serializer) {
//        [self requestSerializer];
//    }
    [self connectionStartGET];
}

- (void)PUTConnectionWithURLString:(NSString *)urlString classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view serializer:(BOOL)serializer response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    [self fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view response:response fail:failure constructingBodyWithBlock:nil];
    
//    if (serializer) {
//        [self requestSerializer];
//    }
    [self connectionStartPUT];
}

@end
