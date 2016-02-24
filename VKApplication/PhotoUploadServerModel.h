//
//  PhotoUploadServerModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 21.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PhotoUploadServerModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *serverPath;

@end
