//
//  AvatarImageProvider.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 21.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AvatarImageProvider : NSObject

-(instancetype)initWithImage:(UIImage *)image andServerPath:(NSString *)serverPath;

@end
