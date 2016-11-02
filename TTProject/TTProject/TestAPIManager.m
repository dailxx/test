//
//  TestAPIManager.m
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "TestAPIManager.h"

@interface TestAPIManager () <ABAPIManagerValidator>

@property (nonatomic, assign) NSInteger pageNumber;

@end

@implementation TestAPIManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - ABAPIManager
- (NSString *)methodName
{
    return @"app/main/logonCheckMssage.json";
}

- (NSString *)serviceType
{
    return kABServiceTest;
}

- (ABAPIManagerRequestType)requestType
{
    return ABAPIManagerRequestTypePost;
}

- (BOOL)shouldCache
{
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params
{
    NSMutableDictionary *mutableParams = [params mutableCopy];
    NSLog(@"before:---%@", mutableParams);
    [mutableParams setObject:@(self.pageNumber) forKey:@"pageno"];
    NSLog(@"after:---%@", mutableParams);
    return params;
}

- (void)loadNextPage
{
    if (self.isLoading) {
        return;
    }
    
    [self loadData];
}

- (BOOL)beforePerformSuccessWithResponse:(ABURLResponse *)response
{
    return YES;
}

#pragma mark - ABAPIManagerValidator
- (BOOL)manager:(ABAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return YES;
}

- (BOOL)manager:(ABAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return YES;
}

@end
