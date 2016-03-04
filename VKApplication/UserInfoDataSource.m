//
//  UserInfoDataSource.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 26.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "UserInfoDataSource.h"
#import "UserInfoModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UserInfoDataSource

- (instancetype)initWithImageView:(UIImageView *)imageView
                        nameLabel:(UILabel *)nameLabel
                        cityLabel:(UILabel *)cityLabel
                    birthdayLabel:(UILabel *)birthdayLabel
                         sexLabel:(UILabel *)sexLabel
                           byInfo:(id)info{
    self = [super init];
    if (self){
        UserInfoModel *user = info[0];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50;
        [imageView sd_setImageWithURL:[NSURL URLWithString:user.photo100 ]];
        nameLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName , user.lastName];
        if (!user.cityInfo){
            cityLabel.text = @"не заполнено";
        }else{
            cityLabel.text = [NSString stringWithFormat:@"%@", user.cityInfo[@"title"]];
        }
        if (!user.birthdayDate){
            birthdayLabel.text = @"не заполнено";
        }else{
            birthdayLabel.text = user.birthdayDate;
        }
        if (user.sexValue){
            if (user.sexValue.integerValue == 1){
                sexLabel.text = @"Женский";
            }else if (user.sexValue.integerValue == 2){
                sexLabel.text = @"Мужской";
            }
        }else{
            sexLabel.text = @"не заполнено";
        }
    }
    return self;
}

@end
