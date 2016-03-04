//
//  NSString+Extension.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


+ (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str{
    
    NSScanner* scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}

+ (NSString *)encodeSearchLink:(NSString *)searchText{
    NSString *link = [NSString stringWithFormat:@"https://api.vk.com/method/users.search?q=%@&sort=0&offset=0&count=1000&fields=photo_100,online,is_friend&v=5.8&access_token=%@",searchText, [LogIn accessToken]];
    NSString *encoded = [link stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    return encoded;
}

+ (NSString *)encodeLink:(NSString *)urlString{
    NSString *encoded = [urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    return encoded;
}

+ (NSString *)dateStandartFormatByUnixTime:(double)unixTime{
    double unixTimeStamp = unixTime;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
