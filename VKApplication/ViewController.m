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
#import "LogInVC.h"


@interface ViewController ()

@end


@implementation ViewController

- (IBAction)logInAction:(id)sender {
    LogInVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInVC"];
    [self.navigationController pushViewController:vc animated:NO];

}

@end
