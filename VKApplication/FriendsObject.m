//
//  FriendsObject.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsObject.h"

@implementation FriendsObject

-(instancetype)initClassWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    _arrayOfFriends = @[].mutableCopy;
    
    for (NSDictionary *d in dictionary[@"response"][@"items"]){
        FriendsModel *f = [[FriendsModel alloc]initClassWithDictionary:d];
        [_arrayOfFriends addObject:f];
    }
    return self;
}

@end
