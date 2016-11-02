//
//  ABScrollViewController.h
//  TTProject
//
//  Created by 张志恒 on 16/9/7.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABMenuBar.h"

@class ABScrollViewController;

@protocol ABScrollViewControllerDelegate <NSObject>
@optional
/**
 * Asks the delegate whether the specified view controller should be made active.
 */
- (BOOL)scrollViewController:(ABScrollViewController *)scrollViewController shouldSelectViewController:(UIViewController *)viewController;

/**
 * Tells the delegate that the user selected an item in the tab bar.
 */
- (void)scrollViewController:(ABScrollViewController *)scrollViewController didSelectViewController:(UIViewController *)viewController;

@end

@interface ABScrollViewController : UIViewController
/**
 *  视图控制器代理对象
 */
@property (nonatomic, weak) id<ABScrollViewControllerDelegate> delegate;
/**
 *  视图控制器数组
 */
@property (nonatomic, strong) NSArray *viewControllers;
/**
 *  菜单栏视图
 */
@property (nonatomic, readonly) ABMenuBar *menuBar;
/**
 *  当前显示的视图控制器
 */
@property (nonatomic, weak) UIViewController *selectedViewController;
/**
 *  当前显示的页面索引
 */
@property (nonatomic) NSUInteger selectedIndex;

@end

@interface UIViewController (ABScrollViewControllerItem)

/**
 * The menu bar item that represents the view controller when added to a menu bar controller.
 */
@property(nonatomic, setter = ab_setMenuBarItem:) ABMenuItem *ab_menuBarItem;

/**
 * The nearest ancestor in the view controller hierarchy that is a menu bar controller. (read-only)
 */
@property(nonatomic, readonly) ABScrollViewController *ab_scrollViewController;

@end
