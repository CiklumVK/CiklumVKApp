//
//  PopoverControllerDataSource.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 23.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WYPopoverController.h>


@protocol PopoverControllerDelegate <NSObject>

- (void)didSelectSortBy:(id)object atIndexPath:(NSIndexPath *)indexPath inPopOver:(WYPopoverController *)popoverController;

@end



@interface PopoverControllerDataSource : NSObject

@property (nonatomic, weak) id <PopoverControllerDelegate> delegate;


- (instancetype)initWithTableView:(UITableView *)tableView byPopOver:(WYPopoverController *)popoverController andClassDelegate:(id)aClass;

@end
