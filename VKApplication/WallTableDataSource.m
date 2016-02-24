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
#import "WallPostModel.h"
#import "WallCell.h"

@interface WallTableDataSource()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate>
@property (weak) UITableView *theTableView;
@property VKClient *vkClient;
@property NSArray *infoArray;
@property NSMutableArray <WallPostModel *> *wallPostsArray;
@property NSMutableArray <UserInfoModel *> *userProfileArray;


@end

@implementation WallTableDataSource

- (instancetype)initWithTableView:(UITableView *)tableView withUserID:(NSNumber *)userID{
    self = [super init];
    if (self){
        self.vkClient = [VKClient new];
        self.infoArray = @[];
        self.wallPostsArray = @[].mutableCopy;
        self.userProfileArray = @[].mutableCopy;
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
        [self.theTableView reloadData];
    }];
    
    [self.vkClient getWallPostsByUserID:self.userID withResponseOfWallPost:^(NSArray *respnseWall) {
        NSArray *responsedArray = [MTLJSONAdapterWithoutNil modelsOfClass:[WallPostModel class] fromJSONArray:[respnseWall valueForKey:@"items"] error:nil];
        NSArray *userArray = [MTLJSONAdapterWithoutNil modelsOfClass:[UserInfoModel class] fromJSONArray:[respnseWall valueForKey:@"profiles"] error:nil];
        self.wallPostsArray = [responsedArray mutableCopy];
        self.userProfileArray = [userArray mutableCopy];
        [self.theTableView reloadData];
        if (refreshControl){
            [refreshControl endRefreshing];
        }
    } userInfo:^(NSArray *responseUser) {

    }];
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

#pragma mark - TableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger a = [LogIn userID].integerValue;
    NSInteger b = self.userID.integerValue;
    if (indexPath.section == 0 && a == b){
        if ([self.delegate respondsToSelector:@selector(didSelectFirstRow) ]){
            [self.delegate didSelectFirstRow];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1){
    UIView *view=[[UIView alloc]init];
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"написать" forState:UIControlStateNormal];
    addButton.frame=CGRectMake(220, -10, [UIScreen mainScreen].bounds.size.width-200, 30);
    [addButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    UIButton *friendsButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [friendsButton setTitle:@"друзья" forState:UIControlStateNormal];
    friendsButton.frame=CGRectMake(0, -10, 100, 30);
    [friendsButton addTarget:self action:@selector(friendsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];


    [view addSubview:addButton];
    [view addSubview:friendsButton];
        return view;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ){
        return 117;
    }else if ([[[[self.wallPostsArray[indexPath.row] valueForKey:@"photo130"]valueForKey:@"type" ] objectAtIndex:0] isEqualToString:@"photo"]){
              return 400;
        }else{
            return 90;
        }

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
        [cell1 fillWithObject:self.infoArray[indexPath.row] atIndex:indexPath];
            return cell1;
    }else{
        WallCell *cell2 = [self.theTableView dequeueReusableCellWithIdentifier:@"WallCell"forIndexPath:indexPath];
        if (self.wallPostsArray.count>0 && cell2){
            WallPostModel *obj = self.wallPostsArray[indexPath.row];
            [cell2 fillWithObject:self.wallPostsArray[indexPath.row] atIndex:indexPath];
            [cell2 fillWithObject:[self userByArray:self.userProfileArray andWallPost:obj] atIndex:indexPath];
        }else{
            [cell2 fillWithObject:@"no posts" atIndex:indexPath];
        }
            return cell2;
    }
}

- (id)userByArray:(NSMutableArray *)userArray andWallPost:(WallPostModel *)wallPost{
    __block id user = nil;
    [userArray enumerateObjectsUsingBlock:^(UserInfoModel * _Nonnull userObject, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([wallPost.senderID isEqualToNumber:userObject.userID]) {
            user = userObject;
        }
    }];
    return user;
}

@end
