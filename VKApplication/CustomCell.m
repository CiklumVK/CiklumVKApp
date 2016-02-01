//
//  CustomCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CustomCell.h"
#import "FriendsModel.h"
#import "CoreDataStack.h"
#import "FriendEntity+CoreDataProperties.h"


@interface CustomCell ()
@property (nonatomic) FriendsModel *friendsModel;
@property (nonatomic) UIImage *imageFromData;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *onlinePicture;


@end


@implementation CustomCell

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath{
//    CoreDataStack *coreDataStack = [CoreDataStack new];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"FriendEntity" inManagedObjectContext:[coreDataStack managedObjectContext]];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [coreDataStack fetchedResult];
//    for (NSManagedObject *info in fetchedObjects) {
//        NSLog(@"lastName: %@", [info valueForKey:@"lastName"]);
//    }
    self.friendsModel = [FriendsModel new];
    self.friendsModel = object;
    self.onlinePicture.alpha = [self.friendsModel.onlineValue boolValue];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.friendsModel.firstName, self.friendsModel.lastName];
    [self.avatarImage setImageWitURLString:self.friendsModel.photoPath];
}

- (void)awakeFromNib{
    
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 25;

}
@end
