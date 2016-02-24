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
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-30,0,0,0)];
    self.dataSource = [[WallTableDataSource alloc] initWithTableView:self.tableView withUserID:self.userID];
    self.dataSource.delegate = self;
    [self setUpaRefreshControl];
   
}

- (void)setUpaRefreshControl{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.bounds = CGRectMake(refreshControl.bounds.origin.x,
                                       30,
                                       refreshControl.bounds.size.width,
                                       refreshControl.bounds.size.height);
    [refreshControl addTarget:self.dataSource action:@selector(loadUserInfo:)
             forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:refreshControl];
}

- (void)didSelectSend:(id)object{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewPostVC *vc = [storyBoard instantiateViewControllerWithIdentifier:@"NewPostVC"];
    vc.userID = object;
    UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([activeController isKindOfClass:[UINavigationController class]]) {
        activeController = [(UINavigationController*) activeController visibleViewController];
    }
    [activeController presentViewController:vc animated:YES completion:nil];
}

- (void)didSelectFriends:(id)object{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendsVC *vc = [storyBoard instantiateViewControllerWithIdentifier:@"FriendsVC"];
    vc.userID = object;
    UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([activeController isKindOfClass:[UINavigationController class]]) {
        activeController = [(UINavigationController*) activeController visibleViewController];
    }
    [activeController.navigationController pushViewController:vc animated:YES];

}

-(void)didSelectFirstRow{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                          message:nil
                                                   preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отменить"
                                             style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action) {
                                           }];
    UIAlertAction *changePictureAction = [UIAlertAction actionWithTitle:@"Изменить фото профиля"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             
                                             self.imagePicker = [[AvatarImagePicker alloc] initWithViewController:self];
                                                    }];
    [alertController addAction:cancelAction];
    [alertController addAction:changePictureAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}


@end
