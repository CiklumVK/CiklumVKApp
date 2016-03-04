//
//  WallPostModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 09.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WallPostModel.h"

@implementation WallPostModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    
    return @{@"dateOfPost":@"date",
             @"textPost":@"text",
             @"senderID":@"from_id",
             @"photo130":@"attachments",
             @"postID":@"id",
             @"repostObject":@"copy_history"};
}
@end
