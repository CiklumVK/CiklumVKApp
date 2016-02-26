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
@property id aClassDelegate;

@end

@implementation PopoverController

- (instancetype)initWithView:(UIView *)view andClassDelegate:(id)aClass{
    self = [super init];
    if (self){
        self.aClassDelegate = aClass;
        [self setUpPopoverControllerWithView:view];
        [self setUpTableview];
    }
    return self;
}

- (void)setUpPopoverControllerWithView:(UIView *)view{
    CGRect popRect = CGRectMake(0, 0,100 ,70);
    self.popoverController = [[WYPopoverController alloc] initWithContentViewController:self];
    self.popoverController.theme.arrowBase = 0;
    self.popoverController.theme.arrowHeight = 0;
    [self.popoverController presentPopoverFromRect:popRect inView:view permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    
}

- (void)setUpTableview{
    UITableView *tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    self.dataSource = [[PopoverControllerDataSource alloc] initWithTableView:tableview byPopOver:self.popoverController andClassDelegate:self.aClassDelegate];
    
}

@end
