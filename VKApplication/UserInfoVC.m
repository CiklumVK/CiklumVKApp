//
//  UserInfoVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 26.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//


#import "UserInfoVC.h"
#import "UserInfoDataSource.h"


@interface UserInfoVC ()

@property UserInfoDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *bDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@end


@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillInfo];
}

- (void)fillInfo{
    self.dataSource = [[UserInfoDataSource alloc] initWithImageView:self.avatarImageView nameLabel:self.nameLabel cityLabel:self.cityLabel birthdayLabel:self.bDateLabel sexLabel:self.sexLabel byInfo:self.userInfo];
}

@end
