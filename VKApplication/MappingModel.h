//
//  MappingModel.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 30.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FillMappingObject <NSObject>

@optional
- (NSDictionary *)dictionaryInstructionManager;

@end


@interface MappingModel : NSObject

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary dictionaryInstructionManager:(NSDictionary *)instruction;

- (void)registerMappingClass:(Class)mappingClass;

- (id)mappingObject;

@end
