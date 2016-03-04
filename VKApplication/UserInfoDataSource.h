//
//  UserInfoDataSource.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 26.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoDataSource : NSObject

- (instancetype)initWithImageView:(UIImageView *)imageView
                        nameLabel:(UILabel *)nameLabel
                        cityLabel:(UILabel *)cityLabel
                    birthdayLabel:(UILabel *)birthdayLabel
                         sexLabel:(UILabel *)sexLabel
                           byInfo:(id)info;

@end
