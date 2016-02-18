//
//  MainNavigationVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 16.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "MainNavigationVC.h"
#import "LogIn.h"
#import "FriendsVC.h"
#import "WallVC.h"

@interface MainNavigationVC ()
@property LogIn * logIn;


@end

@implementation MainNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logIn = [LogIn sharedAuthorization];
    [self.logIn doLogIn:self.view complite:^{
        WallVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WallVC"];
        vc.userID = [LogIn userID] ;
        [self pushViewController:vc animated:NO];
    }];
}

@end
