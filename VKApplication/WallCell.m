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
#import "RepostPostModel.h"
#import "GroupsModel.h"
#import "NSObject+Extension.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface WallCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property UIImageView *imgView;
@property UIView *repostView;
@property WallCell *repostCell;
@end

@implementation WallCell

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath {

    if ([object isKindOfClass:WallPostModel.class]){
        WallPostModel *wallPost = object;
        self.dateLabel.text = [NSString dateStandartFormatByUnixTime:[wallPost.dateOfPost doubleValue]];
        self.postTextLabel.text = wallPost.textPost;
        [self setImageByWallPost:wallPost];
        
    }else if ([object isKindOfClass:UserInfoModel.class]){
        UserInfoModel *user = object;
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName , user.lastName];
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.photo100 ]];
        
    }else if ([object isKindOfClass:NSArray.class]){
        [self addRepostWithObject:object];
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

- (void)awakeFromNib {
    
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 25;
    [self.postTextLabel sizeToFit];
    
}

- (void)addRepostWithObject:(id)object {
    if ([object[0] isKindOfClass:NSString.class]){
        [self.repostView removeFromSuperview];
        [self.repostCell removeFromSuperview];
        return;
    }
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"WallCell" owner:self options:nil];
    self.repostCell = [topLevelObjects objectAtIndex:0];

    
    if ([object[0] isKindOfClass:NSArray.class]){
        
        RepostPostModel *repost = [object[0] objectAtIndex:0];
        self.repostCell.postTextLabel.text = repost.textPost;
        CGFloat textHeight = [NSObject heightByText:repost.textPost labelWidth:304 andFontSize:17];
        
        [[self.repostCell.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 320, textHeight+400)];
        [self.repostCell setFrame:CGRectMake(0, 0, 320, textHeight+400)];
        self.repostCell.dateLabel.text = [NSString dateStandartFormatByUnixTime:repost.dateOfPost.doubleValue];
        if ([[[repost.photo130 valueForKey:@"photo"] objectAtIndex:0] isKindOfClass:NSDictionary.class]){
            [[self.repostCell theImageView] sd_setImageWithURL:[NSURL URLWithString:[[[repost.photo130 valueForKey:@"photo"] valueForKey:@"photo_604"] objectAtIndex:0]]];
        }
        if (object[1]&& [object[1] isKindOfClass:GroupsModel.class]){
            GroupsModel *group = object[1];
            self.repostCell.nameLabel.text = [NSString stringWithFormat:@"➥ %@",group.nameOfGroup ];
            [self.repostCell.avatarImage sd_setImageWithURL:[NSURL URLWithString:group.photo100]];
        }else if (object[1]&& [object[1] isKindOfClass:UserInfoModel.class]){
            UserInfoModel *user = object[1];
            self.repostCell.nameLabel.text = [NSString stringWithFormat:@"➥ %@ %@",user.firstName, user.lastName];
            [self.repostCell.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.photo100]];
        }
        [[self theRepostView] addSubview:self.repostCell];
    }
}


- (UIImageView * )theImageView {
    if (!self.imgView.superview) {
        self.imgView = nil;
        CGFloat textHeight = [NSObject heightByText:self.postTextLabel.text labelWidth:304 andFontSize:17];
        if (self.postTextLabel.text.length == 0){
            textHeight = 0;
        }
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, textHeight+70, [UIScreen mainScreen].bounds.size.width-15, 300)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit ;
        [self addSubview:self.imgView];
    }
    return self.imgView;
}

- (UIView *)theRepostView{
    if (!self.repostView.superview){
        self.repostView = nil;
        CGFloat textHeight = [NSObject heightByText:self.postTextLabel.text labelWidth:304 andFontSize:17];
        if (self.postTextLabel.text.length == 0){
            textHeight = 0;
        }
        self.repostView =[[UIView alloc] initWithFrame:CGRectMake(5, textHeight+70, [UIScreen mainScreen].bounds.size.width-15, textHeight+380)];
        [self addSubview:self.repostView];
    }
    return self.repostView;
}
@end
