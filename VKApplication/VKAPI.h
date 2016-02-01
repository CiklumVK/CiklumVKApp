//
//  VKAPI.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 22.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKAPI : NSObject 

- (void)getFriendListWithResponse:(void (^)(id responseObject))response fail:(void (^)(NSError *error))failure;
- (void)makeSearchWithText:(NSString *)searchText response:(void (^)(id responseObject))response fail:(void (^)(NSError *error))failure;

@end
