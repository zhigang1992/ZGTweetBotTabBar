//
//  ZGTweetBotTabBarViewController.h
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOTIFICATION_STATUS_CHANGED @"NotificationStatusChanged"

@class ZGTweetBotTabBarViewController;

@protocol ZGTweetBotViewControllerDataSource <NSObject>

@optional

- (NSString *)viewControllerTitle:(ZGTweetBotTabBarViewController *)tweetBotTabBarController;
- (BOOL)hasNewNotifications:(ZGTweetBotTabBarViewController *)tweetBotTabBarController;

@required

- (UIImage *)tabBarImage:(ZGTweetBotTabBarViewController *)tweetBotTabBarController;
- (UIImage *)highLightImage:(ZGTweetBotTabBarViewController *)tweetBotTabBarController;

@end

@interface ZGTweetBotTabBarViewController : UIViewController

+ (ZGTweetBotTabBarViewController *)sharedTweetBotTabBarController;

- (void)setSubViewControllers:(NSArray *)subViewController;
- (void)setNotificationStatus:(BOOL)hasNewNotification ForSubViewControllerAtIndex:(NSInteger )index;
- (void)setNotificationStatus:(BOOL)hasNewNotification ForSubViewController:(UIViewController *)viewController;

- (void)setSelecetedSubViewController:(UIViewController *)viewController;
- (void)setSelecetedSubViewControllerAtIndex:(NSInteger )index;


@end
