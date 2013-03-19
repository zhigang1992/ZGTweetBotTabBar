//
//  ViewController.m
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) BOOL hasNotification;
@end

@implementation ViewController

- (IBAction)toggleNotification:(id)sender {
    self.hasNotification = !self.hasNotification;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STATUS_CHANGED object:nil userInfo:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.hasNotification = NO;
}

- (NSString *)imageNameForIndex:(NSInteger )index{
    NSString *imageName;
    switch (index-1) {
        case 0:
            imageName = @"favoritesIcon";
            break;
        case 1:
            imageName = @"mentionsIcon";
            break;
        case 2:
            imageName = @"messagesIcon";
            break;
        case 3:
            imageName = @"searchIcon";
            break;
        case 4:
            imageName = @"timelineIcon";
            break;
        default:
            break;
    }
    return imageName;
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if (aSelector == @selector(hasNewNotifications:)) {
        return self.index != 5;
    } else {
        return [super respondsToSelector:aSelector];
    }
}

- (UIImage *)tabBarImage:(ZGTweetBotTabBarViewController *)tweetBotTabBarController{
    return [UIImage imageNamed:[self imageNameForIndex:self.index]];
}


- (UIImage *)highLightImage:(ZGTweetBotTabBarViewController *)tweetBotTabBarController{
    return [UIImage imageNamed:[[self imageNameForIndex:self.index] stringByAppendingString:@"Highlighted"]];
}

- (BOOL)hasNewNotifications:(ZGTweetBotTabBarViewController *)tweetBotTabBarController{
    return self.hasNotification;
}

@end
