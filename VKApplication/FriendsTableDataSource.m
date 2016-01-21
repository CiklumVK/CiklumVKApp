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

@interface FriendsTableDataSource()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
    FriendsObject *frindsObject;
    UITableView *theTableView;
    NSMutableDictionary *friendsDictionary;
}

@end



@implementation FriendsTableDataSource


- (instancetype)initWithTableView:(UITableView *)tableView withSearchBar:(UISearchBar *)searchBar{
    self = [super init];
    friendsDictionary = @{}.mutableCopy;
    [self loadFriendList:tableView];
    [self configureTableView:tableView];
    [self configureSearchBar:searchBar];

    return self;
}

- (void)loadFriendList:(UITableView *)tableView{
    
    [[VKAPI sharedInstance]GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@",friendsGetPath, [LogIn accessToken]] classMapping:[FriendsObject class] showProgressOnView:nil response:^(NSURLSessionDataTask *operation, id responseObject) {
        frindsObject = responseObject;
        [friendsDictionary setValue:frindsObject.arrayOfFriends forKey:@"Friends"];
        [tableView reloadData];
    } fail:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@", error.description);
    } ];

}

- (void)configureTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
    theTableView = tableView;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [friendsDictionary count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[friendsDictionary allKeys] objectAtIndex:section];
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

#pragma mark - searchBar

- (void)doSearch:(NSString*)searchText{
    NSString *link = [NSString stringWithFormat:@"https://api.vk.com/method/users.search?q=%@&sort=0&fields=photo_100,online,is_friend&v=5.8&access_token=%@",searchText, [LogIn accessToken]];
    NSString *encoded = [link stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    [[VKAPI sharedInstance]GETConnectionWithURLString:encoded classMapping:[frindsObject class] showProgressOnView:nil response:^(NSURLSessionDataTask *operation, id responseObject) {
        frindsObject = responseObject;
        [friendsDictionary setValue:frindsObject.arrayOfFriends forKey:@"Global search"];
        [theTableView reloadData];
    } fail:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
}

- (void)configureSearchBar:(UISearchBar *)searchBar{
    searchBar.delegate = self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self doSearch:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

- (NSArray *)arrayWithSection:(NSInteger)section{
    NSString * str = [friendsDictionary allKeys][section];
    NSArray * a = [friendsDictionary valueForKey:str];
    return a;
}

@end
