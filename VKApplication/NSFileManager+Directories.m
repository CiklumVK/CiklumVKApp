//
//  NSFileManager+Directories.m
//  VKApplication
//
//  Created by Alex on 1/27/16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "NSFileManager+Directories.h"

@implementation NSFileManager (Directories)

+ (NSURL *)applicationDocumentDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
}

@end
