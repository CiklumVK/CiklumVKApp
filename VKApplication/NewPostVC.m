//
//  NewPostVC.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 12.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "NewPostVC.h"
#import "NewPostProvider.h"

@interface NewPostVC ()
@property (weak, nonatomic) IBOutlet UITextField *theTextField;
@property NewPostProvider *postProvider;
@end

@implementation NewPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sendButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
         self.postProvider = [[NewPostProvider alloc] initWithTextField:self.theTextField withUserID:self.userID];
    }];
}

@end
