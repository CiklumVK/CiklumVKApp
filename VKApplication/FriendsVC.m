//
//  FriendsVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsVC.h"
#import "FriendsTableDataSource.h"

@interface FriendsVC ()

@property (nonatomic, strong) FriendsTableDataSource *dataSource;

@end


@implementation FriendsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self loadTableViewWithSearchBar];
}

- (void)loadTableViewWithSearchBar{
    self.dataSource = [[FriendsTableDataSource alloc] initWithTableView:self.theTable withSearchBar:self.searchBarOutlet];
}

- (void)setUpNavigationBar{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Друзья";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    [self.theTable setContentInset:UIEdgeInsetsMake(0,0,0,0)];
}

@end
