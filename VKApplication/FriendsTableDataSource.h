//
//  FriendsTableDataSource.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FriendsTableDataSourceDelegate <NSObject>

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

@end



@interface FriendsTableDataSource : NSObject

@property (nonatomic, weak) id <FriendsTableDataSourceDelegate> delegate;

@property NSNumber *userID;
- (instancetype)initWithTableView:(UITableView *)tableView withSearchBar:(UISearchBar *)searchBar andUserID:(NSNumber *)userID;


@end
