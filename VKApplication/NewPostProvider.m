//
//  NewPostProvider.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 14.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "NewPostProvider.h"
#import "VKClient.h"
@interface NewPostProvider () 

@property VKClient *vkClent;
@end

@implementation NewPostProvider

- (instancetype)initWithTextField:(UITextField *)textField withUserID:(NSNumber *)userID{
    self = [super init];
    if (self){
        self.vkClent = [VKClient new];
        [self sendNewPostByTextField:textField toUserID:userID];
    }
    return  self;
}

- (void)sendNewPostByTextField:(UITextField *)textField toUserID:(NSNumber *)userID{
    if (textField.text.length) {
        [self.vkClent createNewPostOnWallWithMessage:textField.text toUserID:userID];
    }
    
}

@end
