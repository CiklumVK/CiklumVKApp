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
#import "PopoverController.h"

@interface FriendsVC ()<FriendsTableDataSourceDelegate>

@property (nonatomic, strong) FriendsTableDataSource *dataSource;

@property PopoverController *popoverController;

@end


@implementation FriendsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableViewWithSearchBar];
}

- (void)loadTableViewWithSearchBar{
    
    self.dataSource = [[FriendsTableDataSource alloc] initWithTableView:self.theTable withSearchBar:self.searchBarOutlet andUserID:self.userID];
    self.dataSource.delegate = self;
    [self setUpaRefreshControl];
    [self setUpNavigationBarButton];
}

- (void)setUpNavigationBarButton{
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Фильтр"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(sortByPressed:)];
    self.navigationItem.rightBarButtonItem = sortButton;
    
}

- (void)setUpaRefreshControl{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self.dataSource action:@selector(loadFriendList:)
             forControlEvents:UIControlEventValueChanged];
    [self.theTable addSubview:refreshControl];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    WallVC *wallVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WallVC"];
    wallVC.userID = [object valueForKey:@"userID"];
    [self.navigationController pushViewController:wallVC animated:YES];
}

- (IBAction)sortByPressed:(id)sender{
    self.popoverController = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverController"];
    self.popoverController = [[PopoverController alloc] initWithView:self.view andClassDelegate:self.dataSource];
    
}

@end
