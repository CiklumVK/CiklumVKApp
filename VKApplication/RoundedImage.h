//
//  RoundedImage.h
//  VKApplication
//
//  Created by Elena Korenujenko on 07.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RoundedImage : UIImageView

@property IBInspectable BOOL masksToRound;
@property IBInspectable CGFloat radius;



@end
