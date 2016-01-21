//
//  LogIn.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LogIn : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *userID;

- (void)doLogIn:(UIView *)view complite:(void (^)())complite;

+ (instancetype)sharedAuthorization;

+ (NSString *)userID;
+ (NSString *)accessToken;


@end
