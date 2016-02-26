//
//  AlertControllerDataSource.h
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 26.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertControllerDataSource : NSObject

+ (void)showAlertWithAction:(UIAlertAction *)alertAction byViewController:(UIViewController *)viewController;


@end
