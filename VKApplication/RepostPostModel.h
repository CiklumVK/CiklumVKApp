//
//  RepostPostModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 28.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "GroupsModel.h"

@interface RepostPostModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *textPost;
@property (copy, nonatomic) NSNumber *dateOfPost;
@property (copy, nonatomic) NSNumber *senderID;
@property (copy, nonatomic) NSMutableArray *photo130;

@end
