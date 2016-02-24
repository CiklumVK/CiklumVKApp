//
//  VKClient.h
//
//
//  Created by Vasyl Vasylchenko on 01.02.16.
//
//

#import <UIKit/UIKit.h>
#import <Overcoat/Overcoat.h>
#import "PhotoUploadServerModel.h"
#import "MTLJSONAdapterWithoutNil.h"


@interface VKClient : OVCHTTPSessionManager

@property (nonatomic, strong) NSString *searchTextString;


- (void)getFriendsListbyUesrID:(NSNumber *)userID withhResponse:(void (^)(NSArray *responseObject))responseObject;

- (void)makeSearchWithText:(NSString *)searchText response:(void (^)(NSArray *responseObject))responseObject;

- (void)getUserInfoByUserID:(NSNumber *)userID withResponse:(void(^)(NSArray *responseObject))responseObject;

- (void)getWallPostsByUserID:(NSNumber *)userID withResponseOfWallPost:(void (^)(NSArray *respnseWall))responseWall userInfo:(void (^)(NSArray *responseUser))resposeUser;

- (void)createNewPostOnWallWithMessage:(NSString *)message toUserID:(NSNumber *)userID;

- (void)changeAvatarByServer:(NSString *)serverPath withImage:(UIImage *)image withResponse:(void (^)(NSDictionary *responseObject))responseObject;

- (void)getServerForUpLoadPictWithResponse:(void (^)(NSDictionary *responseObject))responseObject;

- (void)savePhotoByServer:(NSNumber *)serverPath withPhotoHash:(NSString *)hash withPhotoDescription:(NSString *)photoDescription withResponse:(void (^)(NSArray *responseObject))responseObject;

@end
