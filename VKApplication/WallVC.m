//
//  WallVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 05.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WallVC.h"
#import "WallTableDataSource.h"
#import "NewPostVC.h"
#import "FriendsVC.h"
#import "AvatarImagePicker.h"
#import "VKClient.h"
#import "AlertControllerManager.h"
#import "UserInfoVC.h"


@interface WallVC () <WallDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property WallTableDataSource *dataSource;
@property AvatarImagePicker *imagePicker;

@end

@implementation WallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView{
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-50,0,0,0)];
    self.dataSource = [[WallTableDataSource alloc] initWithTableView:self.tableView withUserID:self.userID];
    self.dataSource.delegate = self;
    [self setUpaRefreshControl];
    
}

- (UIStoryboard *)currentStoryBoard{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyBoard;
}

- (void)setUpaRefreshControl{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.bounds = CGRectMake(refreshControl.bounds.origin.x,
                                       35,
                                       refreshControl.bounds.size.width,
                                       refreshControl.bounds.size.height);
    [refreshControl addTarget:self.dataSource action:@selector(loadUserInfo:)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)pushToViewController:(UIViewController *)viewController{
    UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([activeController isKindOfClass:[UINavigationController class]]) {
        activeController = [(UINavigationController*) activeController visibleViewController];
    }
    [activeController.navigationController pushViewController:viewController animated:YES];
}

- (void)didSelectSend:(id)object{
    NewPostVC *vc = [[self currentStoryBoard] instantiateViewControllerWithIdentifier:@"NewPostVC"];
    vc.userID = object;
    UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([activeController isKindOfClass:[UINavigationController class]]) {
        activeController = [(UINavigationController*) activeController visibleViewController];
    }
    [activeController presentViewController:vc animated:YES completion:nil];
}

- (void)didSelectFriends:(id)object{
    FriendsVC *vc = [[self currentStoryBoard] instantiateViewControllerWithIdentifier:@"FriendsVC"];
    vc.userID = object;
    [self pushToViewController:vc];
}

- (void)didSelectFirstRow{
    UIAlertAction *changePictureAction = [UIAlertAction actionWithTitle:@"Изменить фото профиля"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    self.imagePicker = [[AvatarImagePicker alloc] initWithViewController:self];
                                                                }];
    [AlertControllerManager showAlertWithAction:changePictureAction byViewController:self];
}

- (void)didSelectPost:(id)post byWallOwner:(NSNumber *)ownerID{
    UIAlertAction *deletePost = [UIAlertAction actionWithTitle:@"Удалить запись"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    VKClient *cl = [VKClient new];
                                                                    [cl deletePostByOwnerID:ownerID andPostID:[post valueForKey:@"postID"]];
                                                                }];
    [AlertControllerManager showAlertWithAction:deletePost byViewController:self];
    
}

- (void)didSelectInfo:(id)info{
    UserInfoVC *vc = [[self currentStoryBoard] instantiateViewControllerWithIdentifier:@"UserInfoVC"];
    vc.userInfo = info;
    [self pushToViewController:vc];
}

@end
