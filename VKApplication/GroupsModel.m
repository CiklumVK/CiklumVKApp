//
//  GroupsModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 29.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "GroupsModel.h"

@implementation GroupsModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"groupID":@"id",
             @"nameOfGroup":@"name",
             @"photo100":@"photo_100"};
}

@end
