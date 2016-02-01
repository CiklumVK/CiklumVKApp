//
//  CoreDataStack.h
//  VKApplication
//
<<<<<<< HEAD
//  Created by Vasyl Vasylchenko on 25.01.16.
=======
//  Created by Alex on 1/27/16.
>>>>>>> origin/master
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
<<<<<<< HEAD
#import <CoreData/CoreData.h>


@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
=======
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

>>>>>>> origin/master
