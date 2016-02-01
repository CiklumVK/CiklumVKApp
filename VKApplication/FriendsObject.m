//
//  FriendsObject.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsObject.h"

@interface FriendsObject ()

@property FriendsModel *friendsModel;

@end

@implementation FriendsObject

-(instancetype)initClassWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    _arrayOfFriends = @[].mutableCopy;
    if (dictionary[@"response"][@"items"]){
    for (NSDictionary *d in dictionary[@"response"][@"items"]){
        self.friendsModel = [[FriendsModel alloc]initClassWithDictionary:d];
        [_arrayOfFriends addObject:self.friendsModel];
    }}
    return self;
}

@end
