//
//  FriendInfoCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 05.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendInfoCell.h"
#import "UserInfoModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FriendInfoCell (){
    
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearsAndCityLabel;

@end



@implementation FriendInfoCell

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath{
    UserInfoModel *user = object;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    self.onlineLabel.hidden = ![user.onlineValue boolValue];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.photo100]];
    if(user.cityInfo){
        self.yearsAndCityLabel.text = [NSString stringWithFormat:@"%@", user.cityInfo[@"title"]];
    }
}

@end
