//
//  PopoverController.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 23.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "PopoverController.h"
#import "PopoverControllerDataSource.h"

@interface PopoverController () 
@property PopoverControllerDataSource *dataSource;
@property WYPopoverController *popoverController;

@end

@implementation PopoverController

- (instancetype)initWithView:(UIView *)view{
    self = [super init];
    if (self){
        [self setUpPopoverControllerWithView:view];
        [self setUpTableview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUpPopoverControllerWithView:(UIView *)view{
    CGRect popRect = CGRectMake(100, 0,100 ,70);
    self.popoverController = [[WYPopoverController alloc] initWithContentViewController:self];
    self.popoverController.theme.arrowBase = 0;
    self.popoverController.theme.arrowHeight = 0;
    [self.popoverController presentPopoverFromRect:popRect inView:view permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    
}

- (void)setUpTableview{
    UITableView *tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableview];
    self.dataSource = [[PopoverControllerDataSource alloc] initWithTableView:tableview byPopOver:self.popoverController];
    
}

@end
