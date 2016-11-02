//
//  ViewController1.m
//  TTProject
//
//  Created by 张志恒 on 16/9/7.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ABScrollViewController.h"
#import "UIColor+ABRandom.h"

@interface ViewController1 ()<ABScrollViewControllerDelegate>

@property (nonatomic, strong) ABScrollViewController *scrollViewController;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIColor *color = kCAEmitterBehaviorColorOverLife;
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    vc2.title = @"测试0";
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    vc3.title = @"测试1";
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    vc4.title = @"测试2";
    
    [viewControllers addObject:vc2];
    [viewControllers addObject:vc3];
    [viewControllers addObject:vc4];
    for (NSInteger i = 3; i < 10; i++) {
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.title = [NSString stringWithFormat:@"测试%@", @(i)];
        viewController.view.backgroundColor = [UIColor ab_randomColor];
        [viewControllers addObject:viewController];
    }
    
    self.scrollViewController = [[ABScrollViewController alloc] init];
    self.scrollViewController.viewControllers = viewControllers;
    self.scrollViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.scrollViewController.view];
    
    for (UIViewController *viewController in viewControllers) {
        [viewController.ab_menuBarItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [viewController.ab_menuBarItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [viewController.ab_menuBarItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected |UIControlStateHighlighted];
    }
}

- (void)scrollViewController:(ABScrollViewController *)scrollViewController didSelectViewController:(UIViewController *)viewController {
    
}

@end













