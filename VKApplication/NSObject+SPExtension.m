//
//  NSObject+SPExtension.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 09.11.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import "NSObject+SPExtension.h"
#import <objc/runtime.h>

@implementation NSObject (SPExtension)

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary InstructionDictionary:(NSDictionary *)instruction {
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyName = [instruction valueForKey:key];
        if (propertyName && ![[obj class] isSubclassOfClass:[NSNull class]]) {
            if ([[obj class] isSubclassOfClass:[NSNumber class]]) {
                [self setValue:[NSString stringWithFormat:@"%@", obj] forKey:propertyName];
            } else {
                [self setValue:obj forKey:propertyName];
            }
        }
    }];
    return self;
}

- (void)printDescription {
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:propertyName];
        if (value)
            propertyValues[propertyName] = value;
        else
            propertyValues[propertyName] = @"nil";
    }
    free(properties);
    NSLog(@"%@", [NSString stringWithFormat:@"\n%@:\n%@", self.class, propertyValues]);
}

- (NSDictionary *)dictionaryClass {
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:propertyName];
        if (value)
            propertyValues[propertyName] = value;
    }
    free(properties);
    
    NSLog(@"%@", propertyValues);
    
    return propertyValues;
}

@end
