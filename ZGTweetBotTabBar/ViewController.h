//
//  ViewController.h
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGTweetBotTabBarViewController.h"

@interface ViewController : UIViewController <ZGTweetBotViewControllerDataSource>
@property (nonatomic) NSInteger index;
@end
