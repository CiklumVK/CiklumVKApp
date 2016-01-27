//
//  CoreDataStack.m
//  VKApplication
//
//  Created by Alex on 1/27/16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CoreDataStack.h"
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

@end
