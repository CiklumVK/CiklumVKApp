//
//  NSObject+Extension.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 02.03.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)


+ (CGFloat)heightByText:(NSString *)text labelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize{
    if (!text.length){
        return 0;
    }
    CGRect r = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                  context:nil];
    return r.size.height;
}

@end
