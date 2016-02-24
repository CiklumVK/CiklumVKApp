//
//  PhotoSaveModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 23.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "PhotoSaveModel.h"

@implementation PhotoSaveModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{@"photoHash":@"hash",
             @"photoDescription":@"photo",
             @"serverNumber":@"server"};
}


@end
