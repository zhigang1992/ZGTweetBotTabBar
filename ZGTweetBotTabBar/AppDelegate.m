//
//  AppDelegate.m
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZGTweetBotTabBarViewController.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UINavigationController *navVC = (UINavigationController *)self.window.rootViewController;
    ZGTweetBotTabBarViewController *tweetBotTabBarController = (ZGTweetBotTabBarViewController *)navVC.topViewController;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    
    ViewController *v1 = [storyBoard instantiateViewControllerWithIdentifier:@"1"];
    v1.index = 1;
    ViewController *v2 = [storyBoard instantiateViewControllerWithIdentifier:@"2"];
    v2.index = 2;
    ViewController *v3 = [storyBoard instantiateViewControllerWithIdentifier:@"3"];
    v3.index = 3;
    ViewController *v4 = [storyBoard instantiateViewControllerWithIdentifier:@"4"];
    v4.index = 4;
    ViewController *v5 = [storyBoard instantiateViewControllerWithIdentifier:@"5"];
    v5.index = 5;
    
    [tweetBotTabBarController setSubViewControllers:@[v1, v2, v3, v4, v5]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
