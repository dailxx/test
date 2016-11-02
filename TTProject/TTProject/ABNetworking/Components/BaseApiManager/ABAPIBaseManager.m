//
//  ABAPIBaseManager.m
//  TTProject
//
//  Created by 张志恒 on 16/9/19.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABAPIBaseManager.h"
#import "ABCache.h"
#import "ABLogger.h"
#import "ABApiProxy.h"
#import "ABAppContext.h"
#import "ABService.h"
#import "ABServiceFactory.h"


#define ABCallAPI(REQUEST_METHOD, REQUEST_ID)                                                  \
{                                                                                               \
    __weak typeof(self) weakSelf = self;                                                        \
    REQUEST_ID = [[ABApiProxy sharedInstance] call##REQUEST_METHOD##WithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(ABURLResponse *response) { \
        __strong typeof(weakSelf) strongSelf = weakSelf;                                        \
        [strongSelf successedOnCallingAPI:response];                                            \
    } fail:^(ABURLResponse *response) {                                                        \
        __strong typeof(weakSelf) strongSelf = weakSelf;                                        \
        [strongSelf failedOnCallingAPI:response withErrorType:ABAPIManagerErrorTypeDefault];    \
    }];                                                                                         \
    [self.requestIdList addObject:@(REQUEST_ID)];                                               \
}

// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const kABAPIBaseManagerRequestID = @"kABAPIBaseManagerRequestID";

@interface ABAPIBaseManager ()

@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) ABAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong) ABCache *cache;

@end

@implementation ABAPIBaseManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = ABAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(ABAPIManager)]) {
            self.child = (id<ABAPIManager>)self;
        } else {
            // 不遵守这个protocol的就让他crash，防止派生类乱来。
            NSAssert(NO, @"子类必须要实现ABAPIManager这个protocol。");
        }
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests
{
    [[ABApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [[ABApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
    [self removeRequestIdWithRequestID:requestID];
}

- (id)fetchDataWithReformer:(id<ABAPIManagerDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - calling api
- (NSInteger)loadData
{
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    if ([self shouldCallAPIWithParams:apiParams]) {
        if ([self.validator manager:self isCorrectWithParamsData:apiParams]) {
            
            // 先检查一下是否有缓存
            if ([self.child shouldCache] && [self hasCacheWithParams:apiParams]) {
                return 0;
            }
            
            // 实际的网络请求
            if ([self isReachable]) {
                self.isLoading = YES;
                switch (self.child.requestType) {
                    case ABAPIManagerRequestTypeGet:
                        ABCallAPI(GET, requestId);
                        break;
                    case ABAPIManagerRequestTypePost:
                        ABCallAPI(POST, requestId);
                        break;
                    case ABAPIManagerRequestTypePut:
                        ABCallAPI(PUT, requestId);
                        break;
                    case ABAPIManagerRequestTypeDelete:
                        ABCallAPI(DELETE, requestId);
                        break;
                    default:
                        break;
                }
                
                NSMutableDictionary *params = [apiParams mutableCopy];
                params[kABAPIBaseManagerRequestID] = @(requestId);
                [self afterCallingAPIWithParams:params];
                return requestId;
            } else {
                [self failedOnCallingAPI:nil withErrorType:ABAPIManagerErrorTypeNoNetWork];
                return requestId;
            }
        } else {
            [self failedOnCallingAPI:nil withErrorType:ABAPIManagerErrorTypeParamsError];
            return requestId;
        }
    }
    return requestId;
}

#pragma mark - api callbacks
- (void)successedOnCallingAPI:(ABURLResponse *)response
{
    self.isLoading = NO;
    self.response = response;
    
    if (response.content) {
        self.fetchedRawData  = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    [self removeRequestIdWithRequestID:response.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:self.fetchedRawData]) {
        if ([self.child shouldCache] && !response.isCache) {
            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
        }
        
        if ([self beforePerformSuccessWithResponse:response]) {
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                [self.delegate managerCallAPIDidSuccess:self];
            }
        }
        [self afterPerformSuccessWithResponse:response];
    } else {
        [self failedOnCallingAPI:response withErrorType:ABAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(ABURLResponse *)response withErrorType:(ABAPIManagerErrorType)errorType
{
    self.isLoading = NO;
    self.response = response;
    
    // 其他错误
    self.errorType = errorType;
    [self removeRequestIdWithRequestID:response.requestId];
    if ([self beforePerformFailWithResponse:response]) {
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
            [self.delegate managerCallAPIDidFailed:self];
        }
    }
    [self afterPerformFailWithResponse:response];
}

#pragma mark - method for interceptor
/*
    拦截器的功能可以由子类通过继承实现，也可以由其它对象实现,两种做法可以共存
    当两种情况共存的时候，子类重载的方法一定要调用一下super
    然后它们的调用顺序是BaseManager会先调用子类重载的实现，再调用外部interceptor的实现
 
    notes:
        正常情况下，拦截器是通过代理的方式实现的，因此可以不需要以下这些代码
        但是为了将来拓展方便，如果在调用拦截器之前manager又希望自己能够先做一些事情，所以这些方法还是需要能够被继承重载的
        所有重载的方法，都要调用一下super,这样才能保证外部interceptor能够被调到
        这就是decorate pattern
 */
- (BOOL)beforePerformSuccessWithResponse:(ABURLResponse *)response
{
    BOOL result = YES;
    
    self.errorType = ABAPIManagerErrorTypeSuccess;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        result = [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
    return result;
}

- (void)afterPerformSuccessWithResponse:(ABURLResponse *)response
{
    if (self!= self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(ABURLResponse *)response
{
    BOOL result = YES;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        result = [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
    return result;
}

- (void)afterPerformFailWithResponse:(ABURLResponse *)response
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

//只有返回YES才会继续调用API
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData
{
    [self.cache clean];
    self.fetchedRawData = nil;
    self.errorMessage = nil;
    self.errorType = ABAPIManagerErrorTypeDefault;
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params
{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

#pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params
{
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params];
    
    if (result == nil) {
        return NO;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        ABURLResponse *response = [[ABURLResponse alloc] initWithData:result];
        response.requestParams = params;
        [ABLogger logDebugInfoWithCachedResponse:response methodName:methodName service:[[ABServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier]];
        [strongSelf successedOnCallingAPI:response];
    });
    
    return YES;
}

#pragma mark - getters and setters
- (ABCache *)cache
{
    if (_cache == nil) {
        _cache = [ABCache sharedInstance];
    }
    return _cache;
}

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable
{
    BOOL isReachability = [ABAppContext sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = ABAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading
{
    if (self.requestIdList.count == 0) {
        _isLoading = NO;
    }
    return _isLoading;
}

@end
