//
//  ProfileInfo.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 28.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "ProfileInfo.h"

@interface ProfileInfo () <NSCoding>

@property NSString *accessToken;
@property NSString *userID;

@end


@implementation ProfileInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
}

@end
