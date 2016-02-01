//
//  LogInModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 21.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "LogInModel.h"

@implementation LogInModel

- (instancetype)init{
    self = [super init];
    self.userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"userID"];
    self.accessToken = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    [self saveInUserDefaults:dictionary];
    self.userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"userID"];
    self.accessToken = [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
    return self;
}

- (void)saveInUserDefaults:(NSDictionary *)dict{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setObject:dict[@"userID"] forKey:@"userID"];
    [userDef setObject:dict[@"accessToken"] forKey:@"accessToken"];
    
    [userDef synchronize];
}


@end
