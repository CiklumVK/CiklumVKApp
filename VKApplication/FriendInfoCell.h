//
//  FriendInfoCell.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 05.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreInfo <NSObject>

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath;

@end

@interface FriendInfoCell : UITableViewCell<StoreInfo>


@end
