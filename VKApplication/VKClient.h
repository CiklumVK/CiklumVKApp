//
//  VKClient.h
//  
//
//  Created by Vasyl Vasylchenko on 01.02.16.
//
//

#import <UIKit/UIKit.h>
#import <Overcoat/Overcoat.h>

@interface VKClient : OVCHTTPSessionManager

- (void)getFriendsListbyUesrID:(NSNumber *)userID withhResponse:(void (^)(NSArray *responseObject))responseObject;
- (void)makeSearchWithText:(NSString *)searchText response:(void (^)(NSArray *responseObject))responseObject;
- (void)getUserInfoByUserID:(NSNumber *)userID withResponse:(void(^)(NSArray *responseObject))responseObject;
- (void)getWallPostsByUserID:(NSNumber *)userID withResponseOfWallPost:(void (^)(NSArray *respnseWall))responseWall userInfo:(void (^)(NSArray *responseUser))resposeUser;
- (void)createNewPostOnWallWithMessage:(NSString *)message toUserID:(NSNumber *)userID;

@property (nonatomic, strong) NSString *searchTextString;

@end
