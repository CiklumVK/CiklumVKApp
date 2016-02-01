//
//  FriendsTableDataSource.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsTableDataSource.h"
#import "CustomCell.h"
#import "FriendsObject.h"
#import "NSString+Extension.h"
#import "VKAPI.h"

@interface FriendsTableDataSource()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property FriendsObject *frindsObject;
@property VKAPI *vkApi;
@property UITableView *theTableView;
@property NSMutableDictionary *friendsDictionary;
@property NSMutableArray *oldFriends;

@end



@implementation FriendsTableDataSource


- (instancetype)initWithTableView:(UITableView *)tableView withSearchBar:(UISearchBar *)searchBar{
    self = [super init];
    self.friendsDictionary = @{}.mutableCopy;
    self.theTableView = [UITableView new];
    self.frindsObject = [FriendsObject new];
    self.vkApi = [VKAPI new];
    [self configureTableView:tableView];
    [self loadFriendList];
    [self configureSearchBar:searchBar];
    
    return self;
}

- (void)configureSearchBar:(UISearchBar *)searchBar{
    searchBar.delegate = self;
}

- (void)configureTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
    self.theTableView = tableView;
}

- (void)loadFriendList{
    [self.vkApi getFriendListWithResponse:^(id responseObject) {
        self.frindsObject = responseObject;
        [self.friendsDictionary setValue:self.frindsObject.arrayOfFriends forKey:@"Friends"];
        self.oldFriends = [self.frindsObject.arrayOfFriends mutableCopy];
        [self.theTableView reloadData];
    } fail:^(NSError *error) {
       NSLog(@"%@", error);
    }];
    
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.friendsDictionary count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.friendsDictionary allKeys] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self arrayWithSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    [cell fillWithObject:[self arrayWithSection:indexPath.section][indexPath.row] atIndex:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark - searchBar

- (void)doSearch:(NSString *)searchText{
    [self.vkApi makeSearchWithText:searchText response:^(id responseObject) {
        self.frindsObject = responseObject;
        NSArray *sortedArray = [self.oldFriends filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"firstName contains %@", searchText]];
        [self.friendsDictionary setValue:self.frindsObject.arrayOfFriends forKey:@"Global search"];
        [self.friendsDictionary setValue:sortedArray forKey:@"Friends"];
        [self.theTableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length==0) {
        [self.friendsDictionary setValue:self.oldFriends forKey:@"Friends"];
        [self.friendsDictionary removeObjectForKey:@"Global search"];
        [self.theTableView reloadData];
    } else {
        [self doSearch:searchText];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [self.friendsDictionary setValue:self.oldFriends forKey:@"Friends"];
    [self.friendsDictionary removeObjectForKey:@"Global search"];
    [self.theTableView reloadData];
}

- (NSArray *)arrayWithSection:(NSInteger)section{
    NSString * str = [self.friendsDictionary allKeys][section];
    NSArray * a = [self.friendsDictionary valueForKey:str];
    return a;
}

@end
