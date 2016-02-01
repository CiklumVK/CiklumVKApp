//
//  LogInModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 21.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *userID;


@end
