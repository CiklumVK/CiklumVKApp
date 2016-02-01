//
//  FriendEntity+CoreDataProperties.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 25.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FriendEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *fristName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *photoPath;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSString *onlineValue;

@end

NS_ASSUME_NONNULL_END
