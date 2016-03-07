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
#import "NSObject+Extension.h"


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

#pragma mark - TableView

- (void)addInfoButtonOnCell:(FriendInfoCell *)cell{
    UIButton *friendsButton=[UIButton buttonWithType:UIButtonTypeInfoDark];
    friendsButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 30, 30, 30);
    [friendsButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:friendsButton];
    
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ){
        return 117;
    }else if ([[[[self.wallPostsArray[indexPath.row] valueForKey:@"photo130"]valueForKey:@"type" ] objectAtIndex:0] isEqualToString:@"photo"]){
        CGFloat height = [NSObject heightByText:[self.wallPostsArray[indexPath.row] valueForKey:@"textPost"] labelWidth:304 andFontSize:17];
        return height+380;
    }else if (![self.repostsArray[indexPath.row] isEqual:@"no repost"]){
        CGFloat height = [NSObject heightByText:[self.wallPostsArray[indexPath.row] valueForKey:@"textPost"] labelWidth:304 andFontSize:17];
        CGFloat repHeight = [NSObject heightByText:[[self.repostsArray[indexPath.row] valueForKey:@"textPost" ]objectAtIndex:0] labelWidth:304 andFontSize:17];

        return height+repHeight+480;
    }else{
      CGFloat height = [NSObject heightByText:[self.wallPostsArray[indexPath.row] valueForKey:@"textPost"] labelWidth:304 andFontSize:17];
        return height+70;
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
        [self addInfoButtonOnCell:cell1];
        [cell1 fillWithObject:self.infoArray[indexPath.row] atIndex:indexPath];
        return cell1;
    }else{
        WallCell *cell2 = [self.theTableView dequeueReusableCellWithIdentifier:@"WallCell"forIndexPath:indexPath];
        if (self.wallPostsArray.count > 0 && cell2){
            WallPostModel *obj = self.wallPostsArray[indexPath.row];
            RepostPostModel *rep = self.repostsArray[indexPath.row];
            NSArray *arr = [NSArray arrayWithObjects:rep,[self getOwneOfRepost:self.groupsArray withUsersArray:self.userProfileArray withRepost:rep], nil];
            [cell2 fillWithWallPost:obj userInfo:[self userByArray:self.userProfileArray andWallPost:obj] andRepost:arr];
        }else{
            cell2 = nil;
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

- (id)getOwneOfRepost:(NSMutableArray *)groupArray withUsersArray:(NSMutableArray *)userArray withRepost:(RepostPostModel *)repost{
    __block id owner = nil;
    if (![repost isEqual:@"no repost"]){
        [groupArray enumerateObjectsUsingBlock:^(GroupsModel * _Nonnull groupObject, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[NSNumber numberWithDouble:fabs([[[repost valueForKey:@"senderID"] objectAtIndex:0] doubleValue])] isEqualToNumber:groupObject.groupID ]) {
                owner = groupObject;
            }
        }];
        if (!owner) {
            [userArray enumerateObjectsUsingBlock:^(UserInfoModel *_Nonnull userObj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([[[repost valueForKey:@"senderID"] objectAtIndex:0] isEqualToNumber:userObj.userID]){
                    owner = userObj;
                }
            }];
        }}
    return owner;
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
