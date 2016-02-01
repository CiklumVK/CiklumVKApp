//
//  UIImageView+VKACash.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 23.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "UIImageView+VKACash.h"

@implementation UIImageView (VKACash)

- (void)setImageWitURLString:(NSString *)stringURL{
    if (!stringURL.length) return;
    self.image = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        NSString *md5 = [NSString MD5StringWithString:stringURL];
        NSString *path = [NSString stringWithFormat:@"%@/%@.png", [NSString applicationDocumentsDirectory], md5];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (!data){
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringURL]];
            [data writeToFile:path atomically:YES];
        } else {
            UIImage *img = [UIImage imageWithData:data];

            dispatch_async(dispatch_get_main_queue(), ^(void){
                self.image = img;
            });
        }
    });
}

@end
