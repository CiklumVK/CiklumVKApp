//
//  WallCell.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 04.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WallCell.h"
#import "NSString+Extension.h"
#import "RepostPostModel.h"
#import "GroupsModel.h"
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


- (void)fillWithWallPost:(WallPostModel *)wallPost userInfo:(UserInfoModel *)user andRepost:(NSArray *)repost {
    self.dateLabel.text = [NSString dateStandartFormatByUnixTime:[wallPost.dateOfPost doubleValue]];
    self.postTextLabel.text = wallPost.textPost;
    [self setImageByWallPost:wallPost];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName , user.lastName];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.photo100 ]];
    [self addRepostWithObject:repost];
    
}

- (void)setImageByWallPost:(WallPostModel *)wallPost {
    
    if ([[[wallPost.photo130 valueForKey:@"type"] objectAtIndex:0] isEqualToString:@"photo"]){
        NSString *urlString = [[[wallPost.photo130 valueForKey:@"photo"] valueForKey:@"photo_604"] objectAtIndex:0];
        [[self theImageViewByText:self.postTextLabel.text andViev:self] sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }else{
        [[self theImageViewByText:self.postTextLabel.text andViev:self] removeFromSuperview];
        [self setBackgroundView:nil];
    }
}

- (void)addRepostWithObject:(id)object {
    if ([object[0] isKindOfClass:NSString.class]){
        [self.repostView  removeFromSuperview];
        self.repostView = nil;
        [self.repostCell removeFromSuperview];
        return;
    } else{
        if (!self.repostCell) {
            self.repostCell = [[[NSBundle mainBundle] loadNibNamed:@"WallCell" owner:self options:nil] firstObject];
        }
        if ([object[0] isKindOfClass:NSArray.class]){
            RepostPostModel *repost = [object[0] objectAtIndex:0];
            self.repostCell.postTextLabel.text = repost.textPost;
            CGFloat textHeight = [NSObject heightByText:repost.textPost labelWidth:304 andFontSize:17];
            self.repostCell.dateLabel.text = [NSString dateStandartFormatByUnixTime:repost.dateOfPost.doubleValue];
            if ([[[repost.photo130 valueForKey:@"photo"] objectAtIndex:0] isKindOfClass:NSDictionary.class] && [[[repost.photo130 valueForKey:@"type"] objectAtIndex:0] isEqualToString:@"photo"]){
                [[self theImageViewByText:repost.textPost andViev:self.repostCell] sd_setImageWithURL:[NSURL URLWithString:[[[repost.photo130 valueForKey:@"photo"] valueForKey:@"photo_604"] objectAtIndex:0]]];
                [self.repostCell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-17, textHeight+pictureHeight+topViewHeight)];
            }else{
                [self.repostCell setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-17, textHeight+topViewHeight)];
                
                [[self theImageViewByText:repost.textPost andViev:self.repostCell] removeFromSuperview];
            }
            if (object[1]&& [object[1] isKindOfClass:GroupsModel.class]){
                GroupsModel *group = object[1];
                self.repostCell.nameLabel.text = [NSString stringWithFormat:@"➥ %@",group.nameOfGroup ];
                [self.repostCell.avatarImage sd_setImageWithURL:[NSURL URLWithString:group.photo100]];
            } else if (object[1]&& [object[1] isKindOfClass:UserInfoModel.class]){
                UserInfoModel *user = object[1];
                self.repostCell.nameLabel.text = [NSString stringWithFormat:@"➥ %@ %@",user.firstName, user.lastName];
                [self.repostCell.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.photo100]];
            }
            
            [self theRepostView];
        }}
}


- (UIImageView * )theImageViewByText:(NSString *)text andViev:(WallCell *)cell {
    CGFloat textHeight = [NSObject heightByText:text labelWidth:304 andFontSize:17];
    
    CGRect newFrame = CGRectMake(8, textHeight+topViewHeight, [UIScreen mainScreen].bounds.size.width-28, pictureHeight);
    if (!cell.imgView.superview) {
        [cell.imgView removeFromSuperview];
        cell.imgView = nil;
        cell.imgView = [UIImageView new];
        cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell addSubview:cell.imgView];
    }
    cell.imgView.frame = newFrame;
    return cell.imgView;
}

- (void)theRepostView {
    CGFloat textHeight = [NSObject heightByText:self.postTextLabel.text labelWidth:304 andFontSize:17];
    CGRect newFrame = CGRectMake(15, textHeight+topViewHeight, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.repostCell.frame));
    if (!self.repostView.superview){
        self.repostView = [UIView new];
        [self.contentView addSubview:self.repostView];
        [self.repostView addSubview:self.repostCell];
    }
    self.repostView.frame = newFrame;
}
@end
