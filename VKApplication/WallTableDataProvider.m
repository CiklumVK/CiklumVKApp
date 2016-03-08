//
//  WallTableDataProvider.m
//  VKApplication
//
//  Created by Elena Korenujenko on 09.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WallTableDataProvider.h"

@implementation WallTableDataProvider


+ (CGFloat)calculateHeightByWallPost:(NSMutableArray<WallPostModel *> *)wallPostArray repost:(NSArray *)repostArray atIndexPath:(NSIndexPath *)indexPath{
    if (wallPostArray.count){
        CGFloat textPostHeight = [NSObject heightByText:[wallPostArray[indexPath.row] valueForKey:@"textPost"] labelWidth:304 andFontSize:17];
        if (indexPath.section == 0 ){
            return 117;
        }else if ([[[[wallPostArray[indexPath.row] valueForKey:@"photo130"]valueForKey:@"type" ] objectAtIndex:0] isEqualToString:@"photo"]){
            return textPostHeight+pictureHeight+topViewHeight+5;
        }else if (![repostArray[indexPath.row] isEqual:@"no repost"]){
            CGFloat repostTextHeight = [NSObject heightByText:[[repostArray[indexPath.row] valueForKey:@"textPost" ]objectAtIndex:0] labelWidth:304 andFontSize:17];
            if (![[[repostArray[indexPath.row] valueForKey:@"photo130"] objectAtIndex:0] isKindOfClass:NSNull.class] &&[[[[[repostArray[indexPath.row]  valueForKey:@"photo130"]valueForKey:@"type"] objectAtIndex:0] objectAtIndex:0] isEqualToString:@"photo"]){
                return repostTextHeight+textPostHeight+pictureHeight+topViewHeight*2+5;
            }else{
                return textPostHeight+repostTextHeight+topViewHeight*2+5;
            }
        }else{
            return textPostHeight+topViewHeight;
        }
    }else{
        return 117;
    }
}

+ (id)userByArray:(NSMutableArray *)userArray andWallPost:(WallPostModel *)wallPost{
    __block id user = nil;
    [userArray enumerateObjectsUsingBlock:^(UserInfoModel * _Nonnull userObject, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([wallPost.senderID isEqualToNumber:userObject.userID]) {
            user = userObject;
        }
    }];
    return user;
}

+ (id)getOwneOfRepost:(NSMutableArray *)groupArray withUsersArray:(NSMutableArray *)userArray withRepost:(RepostPostModel *)repost{
    __block id owner = nil;
    if (![repost isEqual:@"no repost"]){
        [groupArray enumerateObjectsUsingBlock:^(GroupsModel * _Nonnull groupObject, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[NSNumber numberWithDouble:fabs([[[repost valueForKey:@"senderID"] objectAtIndex:0] doubleValue])] isEqualToNumber:groupObject.groupID ]) {
                owner = groupObject;
            }
        }];
        if (!owner) {
            [userArray enumerateObjectsUsingBlock:^(UserInfoModel *_Nonnull userObj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([[[repost valueForKey:@"senderID"] objectAtIndex:0] isEqualToNumber:userObj.userID]){
                    owner = userObj;
                }
            }];
        }}
    return owner;
}


@end
