//
//  RepostPostModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 28.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "RepostPostModel.h"

@implementation RepostPostModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"textPost":@"text",
             @"dateOfPost":@"date",
             @"senderID":@"from_id",
             @"photo130":@"attachments"};
}

@end
