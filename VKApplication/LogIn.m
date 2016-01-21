//
//  LogIn.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 15.01.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "LogIn.h"
#import "NSString+Extension.h"

static LogIn *authorization = nil;


@interface LogIn () <UIWebViewDelegate>

@property UIWebView * vkWebView;

@end



@implementation LogIn{
    void (^_compl)();

}

+ (instancetype)sharedAuthorization{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authorization = [LogIn new];
    });
    return authorization;
}

- (void)doLogIn:(UIView *)view complite:(void (^)())complite{
    _compl = complite;
    [self doLogIn:view];
}

- (void)doLogIn:(UIView *)view{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"]){
        _compl();
    }else{

    self.vkWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.vkWebView.delegate = self;
    self.vkWebView.contentMode = UIViewContentModeScaleAspectFit;
    [self.vkWebView setBackgroundColor:[UIColor clearColor]];
    
    [self.vkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,notify,wall,offline&response_type=token&v=5.42",appID]]]];
    [view addSubview:self.vkWebView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([self.vkWebView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
        authorization.accessToken = [NSString stringBetweenString:@"access_token="
                                           andString:@"&"
                                         innerString:[[[webView request] URL] absoluteString]];
        
        NSArray *userAr = [[[[webView request] URL] absoluteString] componentsSeparatedByString:@"&user_id="];
        authorization.userID = [userAr lastObject];

        if(authorization.accessToken){
            [self.vkWebView removeFromSuperview];
            [self saveInUserDefaults];
            _compl();
        }}
}

+ (NSString *)userID{
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"userID"];
}

+ (NSString *)accessToken{
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"accessToken"];
}

- (void)saveInUserDefaults{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setObject:authorization.userID forKey:@"userID"];
    [userDef setObject:authorization.accessToken forKey:@"accessToken"];
    
    [userDef synchronize];
}

+ (instancetype)initWithDefault{
    NSString * userIDString = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
    NSString * sessionHashString = [[NSUserDefaults standardUserDefaults] stringForKey:@"accesToken"];
    
    if (userIDString) {
        [LogIn sharedAuthorization];
        authorization.userID = userIDString;
        authorization.accessToken = sessionHashString;
    }
    return authorization;
}


@end
