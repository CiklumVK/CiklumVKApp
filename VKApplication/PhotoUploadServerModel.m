//
//  PhotoUploadServerModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 21.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "PhotoUploadServerModel.h"

@implementation PhotoUploadServerModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"serverPath":@"upload_url"};
}

@end
