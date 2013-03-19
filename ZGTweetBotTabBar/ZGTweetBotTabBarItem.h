//
//  ZGTweetBotTabBarItem.h
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGTweetBotTabBarItem;

@protocol ZGTweetBotTabBarItemDelegate <NSObject>
-(void)touchDownForButton:(ZGTweetBotTabBarItem*)button;
-(void)touchUpForButton:(ZGTweetBotTabBarItem*)button;
@end

@interface ZGTweetBotTabBarItem : UIView

@property (nonatomic) BOOL itemSelected;
@property (nonatomic) BOOL hasNotification;

- (void)setBarButtomImage:(UIImage *)tabBarImage highlightedImage:(UIImage *)highlightedImage;

@property (nonatomic) id <ZGTweetBotTabBarItemDelegate> delegate;

@end
