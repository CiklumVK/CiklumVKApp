//
//  CoreDataStack.h
//  VKApplication
//
//  Created by Alex on 1/27/16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSManagedObjectContext;

@interface CoreDataStack : NSObject

@property (atomic, strong, readonly) NSManagedObjectModel *objectModel;
@property (atomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (atomic, strong, readonly) NSManagedObjectContext *managedContext;

//This ensures thread-safety for CoreData
//Use this instead of init
+ (instancetype)sharedStack;

//Creates and returns a new managed object context that is the child of managedContext
- (NSManagedObjectContext *)childManagedContext;

//Persists managedObjectContext to disk
- (void)saveContext;

@end

