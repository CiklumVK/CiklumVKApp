//
//  PhotoSaveModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 23.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PhotoSaveModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSNumber *serverNumber;
@property (copy, nonatomic) NSString *photoDescription;
@property (copy, nonatomic) NSString *photoHash;

@end
