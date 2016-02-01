//
//  MappingModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 30.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "MappingModel.h"


@interface MappingModel ()

@property (nonatomic) id  mappingObject;

@end

@implementation MappingModel

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary dictionaryInstructionManager:(NSDictionary *)instruction {
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

- (void)registerMappingClass:(Class)mappingClass {
    self.mappingObject = [[mappingClass alloc] init];
}

- (id)mappingObject {
    return _mappingObject;
}


@end
