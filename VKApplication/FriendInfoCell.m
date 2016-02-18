//
//  FriendInfoCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 05.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FriendInfoCell (){
    
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end



@implementation FriendInfoCell

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath{
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", [object valueForKey:@"firstName"], [object valueForKey:@"lastName"]];
    self.onlineLabel.hidden = ![[object valueForKey:@"onlineValue"] boolValue];
    [self.avatarImage sd_setImageWithURL:[object valueForKey:@"photo100"]];
}

-(void)awakeFromNib{
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 50;
}

@end
