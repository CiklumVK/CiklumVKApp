//
//  CustomCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CustomCell.h"
#import "FriendsModel.h"
#import "NSString+MD5.h"


@interface CustomCell (){
    FriendsModel *friendsModel;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *onlinePictureOutlet;


@end


@implementation CustomCell

-(void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath{
    friendsModel = object;
 
    self.imageOutlet.layer.masksToBounds = YES;
    self.imageOutlet.layer.cornerRadius = 25;
    
    self.onlinePictureOutlet.alpha = [friendsModel.online boolValue];
    self.nameLabelOutlet.text = [NSString stringWithFormat:@"%@ %@", friendsModel.firstName, friendsModel.lastName];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSString *md5 = [NSString MD5StringWithString:friendsModel.photoPath];
        
        NSMutableString *path = [NSString applicationDocumentsDirectory];
        [path appendFormat:@"/%@.png", md5];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (!data){
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:friendsModel.photoPath]];
            [data writeToFile:path atomically:YES];
        }
        UIImage *img = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.imageOutlet.image = img;
        });
    });
}

@end
