//
//  RoundedImage.m
//  VKApplication
//
//  Created by Elena Korenujenko on 07.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "RoundedImage.h"

@implementation RoundedImage

- (void)awakeFromNib{
    self.layer.masksToBounds = self.masksToRound;
    self.layer.cornerRadius = self.radius;
}

@end
