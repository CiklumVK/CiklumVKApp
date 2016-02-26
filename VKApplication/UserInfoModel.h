//
//  UserInfoModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 08.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserInfoModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *photo100;
@property (copy, nonatomic) NSNumber *onlineValue;
@property (copy, nonatomic) NSNumber *userID;
@property (copy, nonatomic) NSString *birthdayDate;
@property (copy, nonatomic) NSDictionary *cityInfo;



@end
