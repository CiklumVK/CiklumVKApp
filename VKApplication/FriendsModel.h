//
//  FriendsModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappingModel.h"

@interface FriendsModel : MappingModel  <FillMappingObject>

@property (strong, nonatomic) NSString *userDomain;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *onlineValue;
@property (strong, nonatomic) NSString *photoPath;

@end
