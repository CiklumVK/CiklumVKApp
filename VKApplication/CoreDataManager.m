//
//  CoreDataManager.m
//  VKApplication
//
//  Created by Elena Korenujenko on 09.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CoreDataManager.h"
#import "CoreDataStack.h"

@implementation CoreDataManager

+ (void)saveFriendsByResponsedArray:(NSArray *)responsedArray{
    CoreDataStack *stack = [CoreDataStack new];
    for (VKFriendsModel *obj in responsedArray){
        
        FriendEntity *friend = (FriendEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"FriendEntity" inManagedObjectContext:[stack managedObjectContext]];
        friend.fristName = obj.firstName;
        friend.lastName = obj.lastName;
        friend.userID = [NSString stringWithFormat:@"%@",obj.userID ];
        friend.onlineValue = [NSString stringWithFormat:@"%@",obj.onlineValue];
        friend.photoPath = obj.photo100;
        friend.sexFriend = [NSString stringWithFormat:@"%@",obj.sexFriend ];
        [stack saveContext];
    }
  
}

+ (void)deleteEntity{
    CoreDataStack *stack = [CoreDataStack new];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"FriendEntity"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *error;
    [stack.persistentStoreCoordinator executeRequest:delete withContext:[stack managedObjectContext] error:&error];
    if (error){
        NSLog(@"%@", error);
    }
}


@end
