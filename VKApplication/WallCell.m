//
//  WallCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 04.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WallCell.h"
#import "WallPostModel.h"
#import "UserInfoModel.h"
#import "NSString+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface WallCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property  UIImageView *imgView;


@end

@implementation WallCell

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath {
    if ([object isKindOfClass:WallPostModel.class]){
        WallPostModel *wallPost =object;
        self.dateLabel.text = [NSString dateStandartFormatByUnixTime:[wallPost.dateOfPost doubleValue]];
        self.postTextLabel.text = wallPost.textPost;
        [self setImageByWallPost:wallPost];
        
    }else{
        UserInfoModel *user = object;
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName , user.lastName];
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.photo100 ]];
    }
}

- (void)setImageByWallPost:(WallPostModel *)wallPost{
    
    if ([[[wallPost.photo130 valueForKey:@"type"] objectAtIndex:0] isEqualToString:@"photo"]){
        NSString *urlString = [[[wallPost.photo130 valueForKey:@"photo"] valueForKey:@"photo_604"] objectAtIndex:0];
        [[self theImageView] sd_setImageWithURL:[NSURL URLWithString:urlString]];
        UIImageView *imgview =[UIImageView new];
        imgview.alpha = 0.05;
        [imgview sd_setImageWithURL:[NSURL URLWithString:urlString]];
        [self setBackgroundView:imgview];

    }else{
        [[self theImageView] removeFromSuperview];
        [self setBackgroundView:nil];
    }
}

- (UIImageView * )theImageView {
    if (!self.imgView.superview) {
        self.imgView = nil;
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 90, [UIScreen mainScreen].bounds.size.width-15, 300)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit ;
        [self addSubview:self.imgView];
    }
    return self.imgView;
}

- (void)awakeFromNib {
    
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 25;
    [self.postTextLabel sizeToFit];
    
}

@end
