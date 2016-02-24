//
//  NSString+Extension.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


+ (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str;
+ (NSString *)encodeSearchLink:(NSString *)searchText;
+ (NSString *)dateStandartFormatByUnixTime:(double)unixTime;
+ (NSString *)encodeLink:(NSString *)urlString;

@end
