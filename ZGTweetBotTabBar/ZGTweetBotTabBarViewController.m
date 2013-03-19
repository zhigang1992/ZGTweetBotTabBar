//
//  ZGTweetBotTabBarViewController.m
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ZGTweetBotTabBarViewController.h"

@interface ZGTweetBotTabBarViewController ()
@end

@implementation ZGTweetBotTabBarViewController

static ZGTweetBotTabBarViewController *_sharedTweetBotTabBarViewController;

+ (ZGTweetBotTabBarViewController *)sharedTweetBotTabBarController{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTweetBotTabBarViewController = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationStatusChanged:) name:NOTIFICATION_STATUS_CHANGED object:nil];
    });
    return _sharedTweetBotTabBarViewController;
}

- (void)notificationStatusChanged:(NSNotification *)notification{
    //Update Notification status
}



@end
