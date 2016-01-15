//
//  ViewController.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "ViewController.h"

static NSString *appID = @"5227913";

@interface ViewController ()<UIWebViewDelegate>

@property UIWebView *vkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vkWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.vkWebView.delegate = self;
    self.vkWebView.contentMode = UIViewContentModeScaleAspectFit;
    [self.vkWebView setBackgroundColor:[UIColor clearColor]];
    
    [self.vkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,audio&response_type=token&v=5.42",appID]]]];
    [self.view addSubview:self.vkWebView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", self.vkWebView.request.URL.absoluteString);
}


@end
