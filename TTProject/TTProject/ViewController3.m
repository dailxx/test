//
//  ViewController3.m
//  TTProject
//
//  Created by 张志恒 on 16/9/7.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ViewController3.h"
#import "UIColor+ABRandom.h"
#import "ABScrollViewController.h"

@implementation ViewController3

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ab_randomColor];
    
    NSLog(@"%s", __FUNCTION__);
}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    NSLog(@"%s", __FUNCTION__);
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    NSLog(@"%s", __FUNCTION__);
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    NSLog(@"%s", __FUNCTION__);
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    NSLog(@"%s", __FUNCTION__);
//}

@end
