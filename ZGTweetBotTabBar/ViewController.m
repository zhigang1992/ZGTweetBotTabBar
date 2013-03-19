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
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STATUS_CHANGED object:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.hasNotification = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.text = [NSString stringWithFormat:@"%d", self.index];
    [self.view addSubview:label];
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
