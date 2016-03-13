//
//  WallTableDataSource.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 05.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WallTableDataSource.h"
#import "FriendInfoCell.h"
#import "VKClient.h"
#import "WallCell.h"
#import "UserInfoModel.h"
#import "MTLJSONAdapterWithoutNil.h"
#import "WallCell.h"
#import "WallPostModel.h"
#import "RepostPostModel.h"
#import "GroupsModel.h"
#import "WallTableDataProvider.h"

@interface WallTableDataSource()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate>

@property (weak) UITableView *theTableView;
@property VKClient *vkClient;
@property NSArray *infoArray;
@property NSMutableArray <WallPostModel *> *wallPostsArray;
@property NSMutableArray <WallPostModel *> *allWallPostsArray;
@property NSMutableArray <UserInfoModel *> *userProfileArray;
@property NSMutableArray *repostsArray;
@property NSMutableArray <GroupsModel *> *groupsArray;
@property NSDictionary *dic;

@end


@implementation WallTableDataSource

- (instancetype)initWithTableView:(UITableView *)tableView withUserID:(NSNumber *)userID{
    self = [super init];
    if (self){
        self.vkClient = [VKClient new];
        self.infoArray = @[];
        self.wallPostsArray = @[].mutableCopy;
        self.userProfileArray = @[].mutableCopy;
        self.allWallPostsArray = @[].mutableCopy;
        self.repostsArray = @[].mutableCopy;
        self.groupsArray = @[].mutableCopy;
        self.userID = userID;
        [self setUpTableView:tableView];
        [self loadUserInfo:nil];
    }
    return self;
}

- (void)setUpTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"FriendInfoCell" bundle:nil] forCellReuseIdentifier:@"CellFriendInfo"];
    [tableView registerNib:[UINib nibWithNibName:@"WallCell" bundle:nil] forCellReuseIdentifier:@"WallCell"];
    self.theTableView = tableView;
}

- (void)loadUserInfo:(UIRefreshControl *)refreshControl {
    [self.vkClient getUserInfoByUserID:self.userID withResponse:^(NSArray *responseObject) {
        NSArray *responsedArray = [MTLJSONAdapterWithoutNil modelsOfClass:[UserInfoModel class] fromJSONArray:responseObject error:nil];
        self.infoArray = responsedArray;
        
        [self.vkClient getWallPostsByUserID:self.userID withResponseOfWallPost:^(NSArray *respnseWall) {
            [self fillArraysByResponse:respnseWall];
            [self.theTableView reloadData];
            if (refreshControl){
                [refreshControl endRefreshing];
            }
        }];
    }];
}


- (void)fillArraysByResponse:(NSArray *)respnseWall{
    NSArray *responsedArray = [MTLJSONAdapterWithoutNil modelsOfClass:[WallPostModel class] fromJSONArray:[respnseWall valueForKey:@"items"] error:nil];
    NSArray *userArray = [MTLJSONAdapterWithoutNil modelsOfClass:[UserInfoModel class] fromJSONArray:[respnseWall valueForKey:@"profiles"] error:nil];
    self.groupsArray = [MTLJSONAdapterWithoutNil modelsOfClass:[GroupsModel class] fromJSONArray:[respnseWall valueForKey:@"groups"] error:nil].mutableCopy;
    
    for (NSArray *repostArr in [[respnseWall valueForKey:@"items"] valueForKey:@"copy_history"]){
        NSArray *repost = [MTLJSONAdapterWithoutNil modelsOfClass:[RepostPostModel class] fromJSONArray:repostArr error:nil];
        if (repost){
            [self.repostsArray addObject:repost];
        }else{
            [self.repostsArray addObject:@"no repost"];
        }
    }
    self.wallPostsArray = [responsedArray mutableCopy];
    self.allWallPostsArray = self.wallPostsArray;
    self.userProfileArray = [userArray mutableCopy];
}

- (IBAction)sendButtonPressed:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectSend:)]) {
        [self.delegate didSelectSend:self.userID];
    }
}

- (IBAction)friendsButtonPressed:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectFriends:)]) {
        [self.delegate didSelectFriends:self.userID];
    }
}

- (IBAction)infoButtonPressed:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectInfo:)]) {
        [self.delegate didSelectInfo:self.infoArray];
    }
}

- (void)addInfoButtonOnCell:(FriendInfoCell *)cell{
    UIButton *friendsButton=[UIButton buttonWithType:UIButtonTypeInfoDark];
    friendsButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 30, 30, 30);
    [friendsButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:friendsButton];
    
}

#pragma mark - Header for tableview

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1){
        UIView *view=[[UIView alloc]init];
        UIButton *addButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [addButton setTitle:@"написать" forState:UIControlStateNormal];
        addButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 110, -10,100, 30);
        [addButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *friendsButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [friendsButton setTitle:@"друзья" forState:UIControlStateNormal];
        friendsButton.frame=CGRectMake(0, -10, 100, 30);
        [friendsButton addTarget:self action:@selector(friendsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *itemArray = [NSArray arrayWithObjects: @"Все записи", @"Записи владельца", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 125, 29, 250, 20);
        [segmentedControl addTarget:self action:@selector(sortWallPosts:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:segmentedControl];
        [view addSubview:addButton];
        [view addSubview:friendsButton];
        return view;
    }else{
        return nil;
    }
}

#pragma mark - TableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger loginUserID = [LogIn userID].integerValue;
    NSInteger currentUserID = self.userID.integerValue;
    NSInteger senderID = [[self.wallPostsArray[indexPath.row] valueForKey:@"senderID"] integerValue];
    
    if (indexPath.section == 0 && loginUserID == currentUserID){
        if ([self.delegate respondsToSelector:@selector(didSelectFirstRow) ]){
            [self.delegate didSelectFirstRow];
        }
    }else if (loginUserID == senderID && indexPath.section == 1){
        if ([self.delegate respondsToSelector:@selector(didSelectPost:byWallOwner:)])
            [self.delegate didSelectPost:self.wallPostsArray[indexPath.row] byWallOwner:self.userID];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return 50;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [WallTableDataProvider calculateHeightByWallPost:self.wallPostsArray repost:self.repostsArray atIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ){
        return self.infoArray.count;
    }else{
        return self.wallPostsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        FriendInfoCell *cell1 = [self.theTableView dequeueReusableCellWithIdentifier:@"CellFriendInfo" forIndexPath:indexPath];
        [self addInfoButtonOnCell:cell1];
        [cell1 fillWithObject:self.infoArray[indexPath.row] atIndex:indexPath];
        return cell1;
    }else{
        WallCell *cell2 = [self.theTableView dequeueReusableCellWithIdentifier:@"WallCell"forIndexPath:indexPath];
        WallPostModel *obj = self.wallPostsArray[indexPath.row];
        RepostPostModel *rep = self.repostsArray[indexPath.row];
        NSArray *arr = [NSArray arrayWithObjects:rep,[WallTableDataProvider getOwneOfRepost:self.groupsArray withUsersArray:self.userProfileArray withRepost:rep], nil];
        [cell2 fillWithWallPost:obj userInfo:[WallTableDataProvider userByArray:self.userProfileArray andWallPost:obj] andRepost:arr];
        return cell2;
    }
}

#pragma mark - filter

- (void)sortWallPosts:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 1){
        NSNumber *a = [NSNumber numberWithInteger:self.userID.integerValue];
        NSPredicate *p = [NSPredicate predicateWithFormat:@"senderID == %@", a];
        NSArray *sortedArray = [self.allWallPostsArray filteredArrayUsingPredicate:p];
        self.wallPostsArray = sortedArray.mutableCopy;
        [self.theTableView reloadData];
    }else{
        self.wallPostsArray = self.allWallPostsArray;
        [self.theTableView reloadData];
    }
}

@end
