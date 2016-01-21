//
//  NSString+MD5.h
//  ciklumProject1
//
//  Created by Vasyl Vasylchenko on 19.12.15.
//  Copyright © 2015 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
 
+ (NSMutableString *)applicationDocumentsDirectory;

+ (NSString *)MD5StringWithString:(NSString *)string;

@end
