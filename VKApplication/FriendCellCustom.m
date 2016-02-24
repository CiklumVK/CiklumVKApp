//
//  CustomCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendCellCustom.h"
#import "CoreDataStack.h"
#import "FriendEntity+CoreDataProperties.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "VKFriendsModel.h"



@interface FriendCellCustom ()
@property (nonatomic) UIImage *imageFromData;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *onlinePicture;


@end


@implementation FriendCellCustom

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath{
    if ([object isKindOfClass:VKFriendsModel.class]){
        VKFriendsModel *friend = object;
        self.onlinePicture.alpha = [friend.onlineValue boolValue];
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:friend.photo100]];
        
    }else {
        FriendEntity *friend = object;
        self.onlinePicture.alpha = [friend.onlineValue boolValue];
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", friend.fristName, friend.lastName];
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:friend.photoPath]];
        
    }
}
- (void)awakeFromNib{
    
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 25;
    
}
@end
