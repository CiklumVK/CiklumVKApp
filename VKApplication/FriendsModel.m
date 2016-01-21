//
//  FriendsModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsModel.h"

@implementation FriendsModel

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"first_name" : @"firstName",
             @"id" : @"userID",
             @"user_id" : @"userID",
             @"online" : @"online",
             @"last_name" : @"lastName",
             @"photo_100" : @"photoPath"};
}

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary {
    self = [super loadClassWithDictionary:dictionary InstructionDictionary:[self dictionaryInstructionManager]];
    return self;
}

@end
