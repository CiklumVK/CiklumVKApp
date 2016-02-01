//
//  CoreDataStack.m
//  VKApplication
//
<<<<<<< HEAD
//  Created by Vasyl Vasylchenko on 25.01.16.
=======
//  Created by Alex on 1/27/16.
>>>>>>> origin/master
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CoreDataStack.h"
<<<<<<< HEAD

@implementation CoreDataStack




#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "vasylvasylchenko.VKApplication" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"VKApplication" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"VKApplication.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//- (NSArray*)fetchedResult{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"FriendEntity" inManagedObjectContext:[self managedObjectContext]];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    return fetchedObjects;
//}
//- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
//    NSFetchRequest *request = [NSFetchRequest new];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
//    request.predicate = [NSPredicate predicateWithFormat:@"fristName = nil"];
//    [request setEntity:entity];
//    [request setFetchLimit:1];
//    NSError *error = nil;
//    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
//    if (!results) {
//        NSLog(@"Fetch error: %@", error);
//        abort();
//    }
//    if ([results count] == 0) {
//        return NO;
//    }
//    return YES;
//}
=======
#import <CoreData/CoreData.h>
#import "NSFileManager+Directories.h"

static NSString *const CDSModelName = @"VKFeedApp";

@interface CoreDataStack ()

@property (atomic, strong, readonly) NSManagedObjectContext *privateBackgroundContext;

@end

@implementation CoreDataStack

@synthesize objectModel = _objectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedContext = _managedContext;
@synthesize privateBackgroundContext = _privateBackgroundContext;

#pragma mark - Singleton

+ (instancetype)sharedStack {
    static CoreDataStack *_sharedStack = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStack = [self new];
    });
    return _sharedStack;
}

#pragma mark - Initializations and Configurations and Dealocation

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Properties

- (NSManagedObjectModel *)objectModel {
    if (_objectModel == nil) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:CDSModelName withExtension:@"momd"];
        _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    NSAssert(_objectModel != nil, @"Error initializing Managed Object Model!");
    return _objectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
        NSURL *storeURL = [[NSFileManager applicationDocumentDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", CDSModelName, @".sqlite"]];
        NSError *error;
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(error == nil, @"There was an error creating or loading the application's saved data!\nError:%@", error.localizedDescription);
    }
    NSAssert(_persistentStoreCoordinator != nil, @"Error initializing Persistnent Store Coordinator!");
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)privateBackgroundContext {
    if (_privateBackgroundContext == nil) {
        _privateBackgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _privateBackgroundContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    NSAssert(_privateBackgroundContext != nil, @"Error initializing Background Managed Object Model!");
    return _privateBackgroundContext;
}

- (NSManagedObjectContext *)managedContext {
    if (_managedContext == nil) {
        _managedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedContext.parentContext = self.privateBackgroundContext;
    }
    NSAssert(_managedContext != nil, @"Error initializing Managed Object Model!");
    return _managedContext;
}

#pragma mark - Methods

- (NSManagedObjectContext *)childManagedContext {
    NSManagedObjectContext *childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    childContext.parentContext = self.managedContext;
    return childContext;
}

#pragma mark - Saving Support

- (void)contextDidSaveNotification:(NSNotification *)notification {
    NSManagedObjectContext *savedContext = notification.object;
    if ([savedContext.parentContext isEqual:self.privateBackgroundContext] || [savedContext.parentContext isEqual:self.managedContext]) {
        [savedContext.parentContext performBlock:^{
            NSError *error;
            if (![savedContext.parentContext save:&error]) {
                NSLog(@"Error saving context %@!\nError: %@", savedContext.parentContext, error.localizedDescription);
            }
        }];
    }
}

- (void)saveContext {
    NSManagedObjectContext *backgroundContext = self.privateBackgroundContext;
    NSManagedObjectContext *managedContext = self.managedContext;
    NSError *error;
    if (managedContext.hasChanges && ![managedContext save:&error] && ![backgroundContext save:&error]) {
        NSLog(@"Error saving data to database!\nError: %@", error.localizedDescription);
    }
}
>>>>>>> origin/master

@end
