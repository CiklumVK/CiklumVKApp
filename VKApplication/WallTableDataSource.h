//
//  WallTableDataSource.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 05.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WallDelegate <NSObject>

- (void)didSelectSend:(id)object;
- (void)didSelectFriends:(id)object;

@end

@interface WallTableDataSource : NSObject

@property NSNumber *userID;
@property (nonatomic, weak) id <WallDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView withUserID:(NSNumber *)userID;

@end
