//
//  VKClient.m
//  
//
//  Created by Vasyl Vasylchenko on 01.02.16.
//
//

#import "VKClient.h"
#import "VKFriendsModel.h"
#import "NSString+Extension.h"
#import "FriendsTableDataSource.h"
#import "UserInfoModel.h"
#import "WallPostModel.h"
#import "MTLJSONAdapterWithoutNil.h"

const struct APIPaths APIPaths= {
    .friendGetListPath = @"https://api.vk.com/method/friends.get?fields=online,photo_100,sex,bdate&v=5.44&access_token=",
    .searchPeoplePath = @"https://api.vk.com/method/users.search?q=",
    .userInfo = @"https://api.vk.com/method/users.get?",
    .wallPosts = @"https://api.vk.com/method/wall.get?"
   
};



@interface VKClient ()

@end

@implementation VKClient

+ (NSDictionary *)modelClassesByResourcePath {
    return @{APIPaths.friendGetListPath:[VKFriendsModel class],
             APIPaths.searchPeoplePath:[VKFriendsModel class],
             APIPaths.userInfo:[UserInfoModel class],
             APIPaths.wallPosts:[WallPostModel class]};
}
- (void)getFriendsListbyUesrID:(NSNumber *)userID withhResponse:(void (^)(NSArray*))responseObject{
    VKClient *client = [[VKClient alloc] initWithBaseURL:[NSURL URLWithString:APIPaths.friendGetListPath]];
    
    [client GET:[NSString stringWithFormat:@"%@%@&user_id=%@",APIPaths.friendGetListPath, [LogIn accessToken],userID] parameters:nil completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *results = response.result[@"response"][@"items"];
        responseObject(results);
    }];
}

- (void)makeSearchWithText:(NSString *)searchText response:(void (^)(NSArray*))responseObject{
    VKClient *client = [[VKClient alloc] initWithBaseURL:[NSURL URLWithString:APIPaths.searchPeoplePath]];
    
    [client GET:[NSString encodeLink:searchText] parameters:nil completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *responsedArray = response.result[@"response"][@"items"];
        responseObject(responsedArray);
    }];
}

- (void)getUserInfoByUserID:(NSNumber *)userID withResponse:(void(^)(NSArray *))responseObject{
    VKClient *client = [[VKClient alloc] initWithBaseURL:[NSURL URLWithString:APIPaths.userInfo]];
    
    [client GET:[NSString stringWithFormat:@"%@fields=online,photo_100&user_ids=%@&v=5.8&access_token=%@",APIPaths.userInfo,userID, [LogIn accessToken]] parameters:nil completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *results = response.result[@"response"];
        responseObject(results);
    }];
}

- (void)getWallPostsByUserID:(NSNumber *)userID withResponseOfWallPost:(void (^)(NSArray *))responseWall userInfo:(void (^)(NSArray *))resposeUser{
    VKClient *wallClient = [[VKClient alloc] initWithBaseURL:[NSURL URLWithString:APIPaths.wallPosts]];
    int count = 100;
    [wallClient GET:[NSString stringWithFormat:@"%@owner_id=%@&offset=0&count=%d&extended=1&fields=first_name,last_name,photo_100,online&v=5.45&access_token=%@",APIPaths.wallPosts,userID,count, [LogIn accessToken]] parameters:nil completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *results = response.result[@"response"];
        responseWall(results);
    }];
}
- (void)createNewPostOnWallWithMessage:(NSString *)message toUserID:(NSNumber *)userID{
    VKClient *client = [VKClient new];
    
    [client POST:[NSString stringWithFormat:@"https://api.vk.com/method/wall.post?owner_id=%@&message=%@&access_token=%@",userID,message, [LogIn accessToken]] parameters:nil completion:^(OVCResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
}
@end
