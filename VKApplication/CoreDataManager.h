//
//  CoreDataManager.h
//  VKApplication
//
//  Created by Elena Korenujenko on 09.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKFriendsModel.h"
#import "FriendEntity.h"

@interface CoreDataManager : NSObject

+ (void)saveFriendsByResponsedArray:(NSArray *)responsedArray;
+ (void)deleteEntity;


@end
