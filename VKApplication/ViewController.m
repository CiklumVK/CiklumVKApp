//
//  ViewController.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "ViewController.h"
#import "LogIn.h"
#import "FriendsVC.h"


@interface ViewController ()

@property LogIn * logIn;

@end


@implementation ViewController

- (void)viewDidLoad{
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
