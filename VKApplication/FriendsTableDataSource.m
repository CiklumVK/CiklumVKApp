//
//  FriendsTableDataSource.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "FriendsTableDataSource.h"
#import "FriendCellCustom.h"
#import "NSString+Extension.h"
#import "VKClient.h"
#import "VKFriendsModel.h"
#import "MTLJSONAdapterWithoutNil.h"
#import "CoreDataStack.h"
#import "FriendEntity.h"
#import "PopoverControllerDataSource.h"
#import "CoreDataManager.h"


@interface FriendsTableDataSource()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, PopoverControllerDelegate>

@property UITableView *theTableView;
@property NSMutableDictionary *friendsDictionary;
@property (strong) NSMutableArray *oldFriends;
@property (strong) CoreDataStack *coreDataStack;
@property VKClient *vkClient;

@end



@implementation FriendsTableDataSource


- (instancetype)initWithTableView:(UITableView *)tableView withSearchBar:(UISearchBar *)searchBar andUserID:(NSNumber *)userID{
    self = [super init];
    self.userID = userID;
    self.friendsDictionary = @{}.mutableCopy;
    self.oldFriends = @[].mutableCopy;
    self.coreDataStack = [CoreDataStack new];
    self.theTableView = [UITableView new];
    self.vkClient = [VKClient new];
    [self configureTableView:tableView];
    [self loadFriendList:nil];
    [self configureSearchBar:searchBar];
    return self;
}

- (void)configureSearchBar:(UISearchBar *)searchBar{
    searchBar.delegate = self;
}

- (void)configureTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"FriendCellCustom" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
    self.theTableView = tableView;
}

- (void)loadFriendList:(UIRefreshControl *)refreshControl{
    if ([self connected]){
        [CoreDataManager deleteEntity];
        [self.vkClient getFriendsListbyUesrID:self.userID withhResponse:^(NSArray *responseObject) {
            NSArray<VKFriendsModel *> *responsedArray = [MTLJSONAdapterWithoutNil modelsOfClass:[VKFriendsModel class] fromJSONArray:responseObject error:nil];
            [CoreDataManager saveFriendsByResponsedArray:responsedArray];
            NSMutableArray *array = [[self fetchedArray] mutableCopy];
            [self.friendsDictionary setValue:array forKey:@"Friends"];
            self.oldFriends = array;
            [self.theTableView reloadData];
            [refreshControl endRefreshing];
        }];}else{
            NSMutableArray *array = [[self fetchedArray] mutableCopy];
            [self.friendsDictionary setValue:array forKey:@"Friends"];
            self.oldFriends = array;
        }
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
    FriendCellCustom * cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    [cell fillWithObject:[self arrayWithSection:indexPath.section][indexPath.row] atIndex:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self connected]){
        if ([self.delegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
            [self.delegate didSelectObject:[self arrayWithSection:indexPath.section][indexPath.row] atIndexPath:indexPath];
        }}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark - searchBar

- (void)doSearch:(NSString *)searchText{
    [self.vkClient makeSearchWithText:searchText response:^(NSArray *responseObject) {
        NSArray *responsedArray = [MTLJSONAdapterWithoutNil modelsOfClass:[VKFriendsModel class] fromJSONArray:responseObject error:nil];
        NSArray *sortedArray = [self.oldFriends filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(fristName  contains %@) OR (lastName contains %@)", searchText, searchText]];
        [self.friendsDictionary setValue:responsedArray forKey:@"Global search"];
        [self.friendsDictionary setValue:sortedArray forKey:@"Friends"];
        [self.theTableView reloadData];
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

# pragma mark - Sort by

- (void)didSelectSortBy:(id)object atIndexPath:(NSIndexPath *)indexPath inPopOver:(WYPopoverController *)popoverController{
    [popoverController dismissPopoverAnimated:YES completion:^{
        if (indexPath.row == 0){
            NSArray *sortedArray = [self.oldFriends filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"sexFriend contains %@", @"2"]];
            [self.friendsDictionary setValue:sortedArray forKey:@"Friends"];
            [self.theTableView reloadData];
        }else if (indexPath.row == 1){
            NSArray *sortedArray = [self.oldFriends filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"sexFriend contains %@", @"1"]];
            [self.friendsDictionary setValue:sortedArray forKey:@"Friends"];
            [self.theTableView reloadData];
        }else{
            [self.friendsDictionary setValue:self.oldFriends forKey:@"Friends"];
            [self.theTableView reloadData];
        }
    }];
}

# pragma mark - CoreData

- (NSArray *)fetchedArray{
    NSManagedObjectContext *context= [self.coreDataStack managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FriendEntity"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [self.coreDataStack.persistentStoreCoordinator executeRequest:fetchRequest withContext:context error:&error];
    
    return fetchedObjects;
}

# pragma mark - Internet test

- (BOOL)connected{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
        return YES;
    else
        return NO;
}

@end
