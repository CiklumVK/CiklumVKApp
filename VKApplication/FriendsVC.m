//
//  FriendsVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsVC.h"
#import "FriendsTableDataSource.h"
#import "WallVC.h"
#import "NewPostVC.h"

@interface FriendsVC ()<FriendsTableDataSourceDelegate>

@property (nonatomic, strong) FriendsTableDataSource *dataSource;

@end


@implementation FriendsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableViewWithSearchBar];
}

- (void)loadTableViewWithSearchBar{
    [self.theTable setContentInset:UIEdgeInsetsMake(-64,0,0,0)];
    self.dataSource = [[FriendsTableDataSource alloc] initWithTableView:self.theTable withSearchBar:self.searchBarOutlet andUserID:self.userID];
    self.dataSource.delegate = self;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    WallVC *wallVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WallVC"];
    wallVC.userID = [object valueForKey:@"userId"];
    [self.navigationController pushViewController:wallVC animated:YES];
}

@end
