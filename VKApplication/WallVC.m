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

@interface WallVC () <WallDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property WallTableDataSource *dataSource;
@end

@implementation WallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView{
    [self.tableView setContentInset:UIEdgeInsetsMake(-94,0,0,0)];
    self.dataSource = [[WallTableDataSource alloc] initWithTableView:self.tableView withUserID:self.userID];
    self.dataSource.delegate = self;
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
@end
