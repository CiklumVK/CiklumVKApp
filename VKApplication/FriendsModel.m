//
//  FriendsModel.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsModel.h"
#import "CoreDataStack.h"
#import "FriendEntity+CoreDataProperties.h"

@implementation FriendsModel 

- (instancetype)initClassWithDictionary:(NSDictionary *)dictionary{
    MappingModel *m = [MappingModel new];
    NSDictionary *d = @{@"first_name" : @"firstName",
                        @"id" : @"userID",
                        @"user_id" : @"userID",
                        @"online" : @"onlineValue",
                        @"last_name" : @"lastName",
                        @"photo_100" : @"photoPath"};
    m = [self loadClassWithDictionary:dictionary dictionaryInstructionManager:d];
//    CoreDataStack *coreDataStack = [CoreDataStack new];
//    NSManagedObjectContext *context = [coreDataStack managedObjectContext] ;
//    
//    NSEntityDescription* entity = [NSEntityDescription entityForName:@"FriendEntity" inManagedObjectContext:context];
//    FriendEntity *friend = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    if ([coreDataStack coreDataHasEntriesForEntityName:@"FriendEntity"]){
//        friend.fristName = self.firstName;
//        friend.userID = self.userID;
//        friend.lastName = self.lastName;
//        friend.photoPath = self.photoPath;
//        friend.onlineValue = self.online;
//        
//        [coreDataStack saveContext];
//    }
    return self;
}

@end
