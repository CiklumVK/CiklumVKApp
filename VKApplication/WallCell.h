//
//  WallCell.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 04.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol StoreWall <NSObject>

- (void)fillWithObject:(id)object atIndex:(NSIndexPath *)indexPath;

@end



@interface WallCell : UITableViewCell<StoreWall>
@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;

@end
