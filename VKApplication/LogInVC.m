//
//  LogInVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 25.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "LogInVC.h"
#import "NSString+Extension.h"
#import "LogIn.h"
#import "FriendsVC.h"


@interface LogInVC ()

@property LogIn * logIn;

@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doThat];

}

- (void)doThat{
    self.logIn = [LogIn sharedAuthorization];
    [self.logIn doLogIn:self.view complite:^{
        FriendsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendsVC"];
        [self.navigationController pushViewController:vc animated:nil];
    }];
}


@end
