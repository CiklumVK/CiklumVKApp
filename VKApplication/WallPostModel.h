//
//  WallPostModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 09.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface WallPostModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *textPost;
@property (copy, nonatomic) NSNumber *dateOfPost;
@property (copy, nonatomic) NSNumber *senderID;
@property (copy, nonatomic) NSMutableArray *photo130;

@end
