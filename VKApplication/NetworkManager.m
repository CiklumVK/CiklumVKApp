//
//  VKAPI.m
//  VKApp
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "NetworkManager.h"
#import "DataProvider.h"

#import "MappingModel.h"

//const struct APIPaths APIPaths = {
//    .login = @"/login"
//};
@interface NetworkManager ()

@property DataProvider *dataProvider;

@end

@implementation NetworkManager
@synthesize dataProvider;


- (instancetype)init{
    self = [super init];
    self.dataProvider = [DataProvider new];
    return self;
}

+ (instancetype)sharedInstance {
    static NetworkManager *_api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _api = [[NetworkManager alloc] init];
        
    });
    return _api;
}


- (void)connectionStartPOST {
    [dataProvider.theManager POST:dataProvider.theUrlString parameters:dataProvider.theParametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dataProvider.responseBlock(task, dataProvider.theClass ? [dataProvider fillObjectResponseWithDictionary:responseObject] : responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dataProvider.failBlock(task,error);
    }];
}

- (void)connectionStartGET {
    [dataProvider.theManager GET:dataProvider.theUrlString parameters:dataProvider.theParametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MappingModel *mappingModel = [MappingModel new];
        [mappingModel registerMappingClass:dataProvider.theClass];
        dataProvider.responseBlock(task, mappingModel ? [dataProvider fillObjectResponseWithDictionary:responseObject]:responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dataProvider.failBlock(task,error);
    }];
}

- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    [dataProvider fillManagerURLString:urlString parameters:parameters classMapping:classMapping showProgressOnView:view response:response fail:failure];
    
    [self connectionStartPOST];
}

- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view  response:(void (^)(NSURLSessionDataTask *, id))response fail:(void (^)(NSURLSessionDataTask *, NSError *))failure {

    
    [dataProvider fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view response:response fail:failure ];
    
    [self connectionStartGET];
}


@end
