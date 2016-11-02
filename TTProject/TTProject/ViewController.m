//
//  ViewController.m
//  TTProject
//
//  Created by 张志恒 on 16/8/24.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ViewController.h"
#import "ABProgressHUD.h"
#import "ABNavigationBar.h"
#import "UIImage+ABColor.h"
#import "UIView+ABFrame.h"
#import "ABMenubar.h"
#import "TestAPIManager.h"

@interface ViewController () <ABAPIManagerParamSource, ABAPIManagerCallBackDelegate>

@property (nonatomic, strong) TestAPIManager *testAPIManager;

@end

@implementation ViewController {
    NSInteger pageno;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.testAPIManager loadData];
//    [self.testAPIManager loadDataWithParams:<#(NSDictionary *)#>];
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(ABAPIBaseManager *)manager
{
    NSDictionary *params = @{};
    
    if (manager == self.testAPIManager) {
        params = @{@"email": @"zhangzhiheng",
                   @"pwd": @"qq"};
    }
    
    return params;
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(ABAPIBaseManager *)manager
{
    if (manager == self.testAPIManager) {
//        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
    }
    
}

- (void)managerCallAPIDidFailed:(ABAPIBaseManager *)manager
{
    if (manager == self.testAPIManager) {
//        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
    }
}

#pragma mark - getters and setters
- (TestAPIManager *)testAPIManager
{
    if (_testAPIManager == nil) {
        _testAPIManager = [[TestAPIManager alloc] init];
        _testAPIManager.delegate = self;
        _testAPIManager.paramSource = self;
    }
    return _testAPIManager;
}

- (IBAction)show:(id)sender {
    self.testAPIManager.pageNo++;
    [self.testAPIManager loadData];
}


@end
