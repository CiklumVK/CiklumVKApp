//
//  GroupsModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 29.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GroupsModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSNumber *groupID;
@property (copy, nonatomic) NSString *nameOfGroup;
@property (copy, nonatomic) NSString *photo100;



@end
