//
//  VKFriendsModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 02.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VKFriendsModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSNumber *userID;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSNumber *onlineValue;
@property (copy, nonatomic) NSString *photo100;
@property (copy, nonatomic) NSNumber *sexFriend;


@end
