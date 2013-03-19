//
//  ZGTweetBotTabBarItem.m
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ZGTweetBotTabBarItem.h"


#define kDefaultNotificationHeight  4.0f

@interface ZGTweetBotTabBarItem()
@property (nonatomic) UIButton *button;
@property (nonatomic) UIImageView *notificationView;
@end

@implementation ZGTweetBotTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(1, 1, frame.size.width-2, frame.size.height-2-4);
        
        UIImage *tabBarButtonBackground = [[UIImage imageNamed:@"tabBarButtonBackground"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        UIImage *tabBarButtonBackgroundHighlighted = [[UIImage imageNamed:@"tabBarButtonBackgroundHighlighted"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        
        [self.button setBackgroundImage:tabBarButtonBackground forState:UIControlStateNormal];
        [self.button setBackgroundImage:tabBarButtonBackgroundHighlighted forState:UIControlStateHighlighted];
        [self.button setBackgroundImage:tabBarButtonBackgroundHighlighted forState:UIControlStateSelected];
        
        [self.button addTarget:self action:@selector(touchDownForButton:) forControlEvents:UIControlEventTouchDown];
        [self.button addTarget:self action:@selector(touchUpForButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.button];
        
        self.notificationView = [[UIImageView alloc] initWithFrame:CGRectMake(1, frame.size.height-kDefaultNotificationHeight, frame.size.width-2, kDefaultNotificationHeight)];
        
        [self.notificationView setImage:[[UIImage imageNamed:@"tabBarNotificationLightOff"] stretchableImageWithLeftCapWidth:1 topCapHeight:0]];
        [self.notificationView setHighlightedImage:[[UIImage imageNamed:@"tabBarNotificationLightOn"] stretchableImageWithLeftCapWidth:1 topCapHeight:0]];
        
        [self addSubview:self.notificationView];
        
        [self bringSubviewToFront:self.notificationView];
        
        self.itemSelected = NO;
        self.hasNotification = NO;
    }
    return self;
}

- (void)setBarButtomImage:(UIImage *)tabBarImage highlightedImage:(UIImage *)highlightedImage{
    [self.button setImage:tabBarImage forState:UIControlStateNormal];
    [self.button setImage:highlightedImage forState:UIControlStateSelected];
    [self.button setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (void)setItemSelected:(BOOL)itemSelected{
    self.button.selected = itemSelected;
}

- (BOOL)itemSelected{
    return self.button.selected;
}

- (void)setHasNotification:(BOOL)hasNotification{
    self.notificationView.highlighted = hasNotification;
}

- (BOOL)hasNotification{
    return self.notificationView.highlighted;
}

- (void)touchDownForButton:(UIButton *)button{
    [self.delegate touchDownForButton:self];
}

- (void)touchUpForButton:(UIButton *)button{
    [self.delegate touchUpForButton:self];
}

@end
