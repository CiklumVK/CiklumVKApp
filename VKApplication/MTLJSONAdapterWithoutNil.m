//
//  MTLJSONAdapterWithoutNil.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 04.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "MTLJSONAdapterWithoutNil.h"

@implementation MTLJSONAdapterWithoutNil

- (NSSet *)serializablePropertyKeys:(NSSet *)propertyKeys forModel:(id<MTLJSONSerializing>)model {
    NSMutableSet *ms = propertyKeys.mutableCopy;
    NSDictionary *modelDictValue = [model dictionaryValue];
    for (NSString *key in ms) {
        id val = [modelDictValue valueForKey:key];
        if ([[NSNull null] isEqual:val]) { 
            [ms removeObject:key];
        }
    }
    return [NSSet setWithSet:ms];
}

@end
