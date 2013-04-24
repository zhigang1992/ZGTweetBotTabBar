//
//  ZGTweetBotTabBarViewController.m
//  ZGTweetBotTabBar
//
//  Created by Kyle Fang on 3/19/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "ZGTweetBotTabBarViewController.h"
#import "ZGTweetBotTabBarItem.h"

#define kDefaultTabBarHeight    45.0f

@interface ZGTweetBotTabBarViewController () <ZGTweetBotTabBarItemDelegate>
@property (nonatomic) UIView *tweetBotTabBar;
@property (nonatomic) UIViewController *currentViewController;
@end

@implementation ZGTweetBotTabBarViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationStatusChanged:) name:NOTIFICATION_STATUS_CHANGED object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notificationStatusChanged:(NSNotification *)notification{
    //Update Notification status
    NSLog(@"%@", notification);
    for (int i=0; i<self.subViewControllers.count; i++) {
        UIViewController <ZGTweetBotViewControllerDataSource> *viewController = [self.subViewControllers objectAtIndex:i];
        ZGTweetBotTabBarItem *barButomItem = (ZGTweetBotTabBarItem *)[self.tweetBotTabBar viewWithTag:i+100];
        if ([viewController respondsToSelector:@selector(hasNewNotifications:)]) {
            barButomItem.hasNotification = [viewController hasNewNotifications:self];
        } else {
            barButomItem.showNotificationField = NO;
        }
    }
}


- (UIView *)tweetBotTabBar{
    if (!_tweetBotTabBar) {
        _tweetBotTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - kDefaultTabBarHeight, self.view.frame.size.width, kDefaultTabBarHeight)];
        _tweetBotTabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _tweetBotTabBar.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_tweetBotTabBar];
        [self.view bringSubviewToFront:_tweetBotTabBar];
    }
    return _tweetBotTabBar;
}


- (void)setSubViewControllers:(NSArray *)subViewControllers{
    if (subViewControllers != _subViewControllers) {
        for (UIViewController *viewController in subViewControllers) {
            NSAssert([viewController conformsToProtocol:@protocol(ZGTweetBotViewControllerDataSource)], @"ViewController Don't confirm to protocol");
        }
        _subViewControllers = subViewControllers;
        [self updateViewControllers];
    }
}

- (void)updateViewControllers{
    for (UIView *subView in self.tweetBotTabBar.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat buttonLength = round(self.view.frame.size.width/self.subViewControllers.count);
    
    ZGTweetBotTabBarItem *selectedButton;
    for (int i=0; i<self.subViewControllers.count; i++) {
        UIViewController <ZGTweetBotViewControllerDataSource> *viewController = [self.subViewControllers objectAtIndex:i];
        
        ZGTweetBotTabBarItem *barButomItem = [[ZGTweetBotTabBarItem alloc] initWithFrame:CGRectMake(buttonLength * i, 1, buttonLength, kDefaultTabBarHeight-1)];
        [barButomItem setBarButtomImage:[viewController tabBarImage:self] highlightedImage:[viewController highLightImage:self]];
        if ([viewController respondsToSelector:@selector(hasNewNotifications:)]) {
            barButomItem.hasNotification = [viewController hasNewNotifications:self];
        } else {
            barButomItem.showNotificationField = NO;
        }
        if (i == self.selectedViewControllerIndex) {
            barButomItem.itemSelected = YES;
            selectedButton = barButomItem;
        }
        
        barButomItem.delegate = self;
        
        [self.tweetBotTabBar addSubview:barButomItem];
        barButomItem.tag = i+100;

    }
    
    [self touchDownForButton:selectedButton];
    [self touchUpForButton:selectedButton];

}

- (void)touchDownForButton:(ZGTweetBotTabBarItem *)button{
    [self cycleFromViewControllerToIndex:button.tag-100 withCompletionBlock:nil];
    ZGTweetBotTabBarItem *item = (ZGTweetBotTabBarItem *)[self.tweetBotTabBar viewWithTag:self.selectedViewControllerIndex+100];
    item.itemSelected = NO;
    button.itemSelected = YES;
    self.selectedViewControllerIndex = button.tag-100;
}

- (void)touchUpForButton:(ZGTweetBotTabBarItem *)button{
    ZGTweetBotTabBarItem *item = (ZGTweetBotTabBarItem *)[self.tweetBotTabBar viewWithTag:self.selectedViewControllerIndex+100];
    item.itemSelected = NO;
    button.itemSelected = YES;  
    self.selectedViewControllerIndex = button.tag-100;
}

- (void)cycleFromViewControllerToIndex:(NSInteger )newIndex withCompletionBlock:(void (^)(BOOL finished))completionBlock{
    
    UIViewController *oldVC = self.currentViewController;
    UIViewController *newVC = [self.subViewControllers objectAtIndex:newIndex];
    
    // Do nothing if we are attempting to swap to the same view controller
    if (newVC == oldVC) return;
    
    // Check the newVC is non-nil otherwise expect a crash: NSInvalidArgumentException
    if (newVC) {
        
        // Set the new view controller frame (in this case to be the size of the available screen bounds)
        // Calulate any other frame animations here (e.g. for the oldVC)
        newVC.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        
        
        // Check the oldVC is non-nil otherwise expect a crash: NSInvalidArgumentException
        if (oldVC) {
            
            // Start both the view controller transitions
            [oldVC willMoveToParentViewController:nil];
            [self addChildViewController:newVC];
            
            newVC.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));

            [oldVC removeFromParentViewController];
            [newVC didMoveToParentViewController:self];
            self.currentViewController = newVC;
            // Store a reference to the current controller
            if (completionBlock) {
                completionBlock(YES);
            }
            
        } else {
            
            // Otherwise we are adding a view controller for the first time
            // Start the view controller transition
            [self addChildViewController:newVC];
            
            // Add the new view controller view to the ciew hierarchy
            [self.view addSubview:newVC.view];
            
            // End the view controller transition
            [newVC didMoveToParentViewController:self];
            
            // Store a reference to the current controller
            
            if (completionBlock) {
                completionBlock(YES);
            }
        }
    }
    
    [self.view bringSubviewToFront:self.tweetBotTabBar];
}

@end
