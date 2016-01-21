//
//  NSObject+SPExtension.h
//  SocketProject
//
//  Created by Genrih Korenujenko on 09.11.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FillObjectProtocol <NSObject>

@optional
- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary;

@end

@interface NSObject (SPExtension)<FillObjectProtocol>

- (instancetype)loadClassWithDictionary:(NSDictionary *)dictionary InstructionDictionary:(NSDictionary *)instruction;

- (void)printDescription;

- (NSDictionary *)dictionaryClass;



@end
