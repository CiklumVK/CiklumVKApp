//
//  CustomCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CustomCell.h"
#import "CoreDataStack.h"
#import "CoreDataStack.h"
#import "FriendEntity+CoreDataProperties.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface CustomCell ()
@property (nonatomic) UIImage *imageFromData;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *onlinePicture;


@end


@implementation CustomCell

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath{
    
    self.onlinePicture.alpha = [[object valueForKey:@"onlineValue"] boolValue];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [object valueForKey:@"firstName"], [object valueForKey:@"lastName"]];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[object valueForKey:@"photo100"]]];
    
}

- (void)awakeFromNib{
    
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 25;

}
@end
