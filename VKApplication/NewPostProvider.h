//
//  NewPostProvider.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 14.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewPostProvider : NSObject

- (instancetype)initWithTextField:(UITextField *)textField withUserID:(NSNumber *)userID;

@end
