//
//  PopoverControllerDataSource.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 23.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "PopoverControllerDataSource.h"
#import "FriendsTableDataSource.h"

@interface PopoverControllerDataSource ()<UITableViewDelegate, UITableViewDataSource,WYPopoverControllerDelegate>

@property NSArray *arrayOfSortWays;
@property FriendsTableDataSource *friendsTableDataSource;
@property WYPopoverController *popoverController;
@end

@implementation PopoverControllerDataSource

- (instancetype)initWithTableView:(UITableView *)tableView byPopOver:(WYPopoverController *)popoverController andClassDelegate:(id)aClass{
    self = [super init];
    if (self){
        self.friendsTableDataSource = aClass;
        [self setUpTableView:tableView];
        self.arrayOfSortWays = @[@"Показать только мужчин",@"Показать только женщин",@"Показать всех"];
        self.popoverController = popoverController;
    }
    return  self;
}

- (void)setUpTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;

}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.arrayOfSortWays[indexPath.row]];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.delegate = self.friendsTableDataSource;
    if ([self.delegate respondsToSelector:@selector(didSelectSortBy:atIndexPath:inPopOver:)]){
        [self.delegate didSelectSortBy:self.arrayOfSortWays[indexPath.row] atIndexPath:indexPath inPopOver:self.popoverController];
    }
}

#pragma mark - PopOverController

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller{
    self.popoverController.delegate = nil;
    self.popoverController = nil;
}

@end
