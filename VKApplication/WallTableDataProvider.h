//
//  WallTableDataProvider.h
//  VKApplication
//
//  Created by Elena Korenujenko on 09.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepostPostModel.h"
#import "WallPostModel.h"
#import "UserInfoModel.h"

@interface WallTableDataProvider : NSObject

+ (CGFloat)calculateHeightByWallPost:(NSMutableArray<WallPostModel *> *)wallPostArray repost:(NSArray *)repostArray atIndexPath:(NSIndexPath *)indexPath;
+ (id)userByArray:(NSMutableArray *)userArray andWallPost:(WallPostModel *)wallPost;
+ (id)getOwneOfRepost:(NSMutableArray *)groupArray withUsersArray:(NSMutableArray *)userArray withRepost:(RepostPostModel *)repost;

@end
