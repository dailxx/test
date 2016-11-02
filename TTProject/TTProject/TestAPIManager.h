//
//  TestAPIManager.h
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABNetworking.h"
#import "TestService.h"

@interface TestAPIManager : ABAPIBaseManager <ABAPIManager>

- (void)loadNextPage;

@end
