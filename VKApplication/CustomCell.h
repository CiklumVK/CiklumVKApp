//
//  CustomCell.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Store <NSObject>

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath;

@end


@interface CustomCell : UITableViewCell<Store>

@end
