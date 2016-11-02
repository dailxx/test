//
//  ABScrollViewController.m
//  TTProject
//
//  Created by 张志恒 on 16/9/7.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABScrollViewController.h"
#import <objc/runtime.h>

@interface UIViewController (ABScrollViewControllerItemInternal)

- (void)ab_setMenuBarController:(ABScrollViewController *)menuBarController;

@end

@interface ABScrollViewController ()<UIScrollViewDelegate, ABMenuBarDelegate>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) ABMenuBar *menuBar;

@end

@implementation ABScrollViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self contentView]];
    [self.view addSubview:[self menuBar]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewControllers[[self selectedIndex]] beginAppearanceTransition:YES animated:NO];
    [self setSelectedIndex:[self selectedIndex]];
    [self.viewControllers[[self selectedIndex]] endAppearanceTransition];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize viewSize = self.view.bounds.size;
    CGFloat menuBarHeight = CGRectGetHeight([[self menuBar] frame]);
    
    if (!menuBarHeight) {
        menuBarHeight = 44.f;
    }
    
    [[self menuBar] setFrame:CGRectMake(0, 20, viewSize.width, menuBarHeight)];
    
    CGFloat contentViewStartingY = CGRectGetMaxY([[self menuBar] frame]);
    CGFloat contentViewHeight =  viewSize.height - contentViewStartingY;
    [[self contentView] setFrame:CGRectMake(0, contentViewStartingY, viewSize.width, contentViewHeight)];
    [[self contentView] setContentSize:CGSizeMake(viewSize.width * self.viewControllers.count, contentViewHeight)];
}

#pragma mark - setter and getter
- (UIViewController *)selectedViewController
{
    return [self.viewControllers objectAtIndex:self.selectedIndex];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex >= self.viewControllers.count) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    [[self menuBar] setSelectedItem:[[self menuBar] items][selectedIndex]];
    
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedIndex]];
    if ([self selectedViewController].view.superview &&
        [self selectedViewController].view.superview != self.contentView) {
        [[self selectedViewController].view removeFromSuperview];
    }
    
    CGSize contentViewSize = [[self contentView] bounds].size;
    if (![self selectedViewController].view.superview) {
        [self addChildViewController:[self selectedViewController]];
        [[[self selectedViewController] view] setFrame:CGRectMake(contentViewSize.width*selectedIndex, 0, contentViewSize.width, contentViewSize.height)];
        [[self contentView] addSubview:[[self selectedViewController] view]];
        [[self selectedViewController] didMoveToParentViewController:self];
    }
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        
         NSMutableArray *menuBarItems = [[NSMutableArray alloc] init];
        for (UIViewController *viewController in viewControllers) {
            ABMenuItem *menuBarItem = [ABMenuItem buttonWithType:UIButtonTypeCustom];
            [menuBarItem setTitle:viewController.title forState:UIControlStateNormal];
            [menuBarItems addObject:menuBarItem];
            [viewController ab_setMenuBarController:self];
        }
        
        [[self menuBar] setItems:menuBarItems];
    } else {
        for (UIViewController *viewController in _viewControllers) {
            [viewController ab_setMenuBarController:nil];
        }
        
        _viewControllers = nil;
    }
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
    UIViewController *searchedController = viewController;
    if ([searchedController navigationController]) {
        searchedController = [searchedController navigationController];
    }
    return [[self viewControllers] indexOfObject:searchedController];
}

- (ABMenuBar *)menuBar {
    if (!_menuBar) {
        _menuBar = [[ABMenuBar alloc] init];
        _menuBar.delegate = self;
        _menuBar.itemWidth = 80.f;
        [_menuBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleTopMargin|
                                      UIViewAutoresizingFlexibleLeftMargin|
                                      UIViewAutoresizingFlexibleRightMargin|
                                      UIViewAutoresizingFlexibleBottomMargin)];
    }
    return _menuBar;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
        [_contentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                           UIViewAutoresizingFlexibleHeight)];
    }
    return _contentView;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    if (index != self.selectedIndex) {
        [self.viewControllers[index] beginAppearanceTransition:YES animated:NO];
        [self setSelectedIndex:index];
        [self.viewControllers[index] endAppearanceTransition];
    }
}

#pragma mark - ABMenuBarDelegate

- (BOOL)menuBar:(ABMenuBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(scrollViewController:shouldSelectViewController:)]) {
        if (![self.delegate scrollViewController:self shouldSelectViewController:self.viewControllers[index]]) {
            return NO;
        }
    }
    
    if ([self selectedViewController] == [self viewControllers][index]) {
        if ([[self selectedViewController] isKindOfClass:[UINavigationController class]]) {
            UINavigationController *selectedController = (UINavigationController *)[self selectedViewController];
            
            if ([selectedController topViewController] != [selectedController viewControllers][0]) {
                [selectedController popToRootViewControllerAnimated:YES];
            }
        }
        
        return NO;
    }
    
    return YES;
}

- (void)menuBar:(ABMenuBar *)menuBar didSelectItemAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.viewControllers.count) {
        return;
    }
    
//    for (UIViewController *viewController in self.viewControllers) {
//        if (viewController != self.viewControllers[index]) {
//            [viewController beginAppearanceTransition:NO animated:NO];
//            [viewController endAppearanceTransition];
//        }
//    }
    
    // 子视图控制器的声明周期
    [self.viewControllers[index] beginAppearanceTransition:YES animated:NO];
    [self setSelectedIndex:index];
    [self.viewControllers[index] endAppearanceTransition];
    
    [[self contentView] setContentOffset:CGPointMake(CGRectGetWidth(self.contentView.bounds)*index, 0)];
    
    if ([self.delegate respondsToSelector:@selector(scrollViewController:didSelectViewController:)]) {
        [self.delegate scrollViewController:self didSelectViewController:self.viewControllers[index]];
    }
}

@end

#pragma mark - UIViewController+ABScrollViewControllerItem

@implementation UIViewController (ABScrollViewControllerItemInternal)

- (void)ab_setMenuBarController:(ABScrollViewController *)menuBarController {
    objc_setAssociatedObject(self, @selector(ab_scrollViewController), menuBarController, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIViewController (ABScrollViewControllerItem)

- (ABScrollViewController *)ab_scrollViewController {
    ABScrollViewController *menuBarController = objc_getAssociatedObject(self, @selector(ab_scrollViewController));
    
    if (!menuBarController && self.parentViewController) {
        menuBarController = [self.parentViewController ab_scrollViewController];
    }
    
    return menuBarController;
}

- (ABMenuItem *)ab_menuBarItem {
    ABScrollViewController *menuBarController = [self ab_scrollViewController];
    NSInteger index = [menuBarController indexForViewController:self];
    return [[[menuBarController menuBar] items] objectAtIndex:index];
}

- (void)ab_setMenuBarItem:(ABMenuItem *)ab_menuBarItem {
    ABScrollViewController *menuBarController = [self ab_scrollViewController];
    
    if (!menuBarController) {
        return;
    }
    
    ABMenuBar *menuBar = [menuBarController menuBar];
    NSInteger index = [menuBarController indexForViewController:self];
    
    NSMutableArray *menuBarItems = [[NSMutableArray alloc] initWithArray:[menuBar items]];
    [menuBarItems replaceObjectAtIndex:index withObject:ab_menuBarItem];
    [menuBar setItems:menuBarItems];
}

@end
















