//
//  ABApiProxy.m
//  TTProject
//
//  Created by 张志恒 on 16/9/19.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABApiProxy.h"
#import "AFNetworking.h"
#import "ABLogger.h"
#import "ABRequestGenerator.h"
#import "NSURLRequest+ABNetworkingAddtions.h"

@interface ABApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ABApiProxy

#pragma mark - getters and setters
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    return _sessionManager;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ABApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ABApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ABCallback)success
                          fail:(ABCallback)fail
{
    NSURLRequest *request = [[ABRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(ABCallback)success
                           fail:(ABCallback)fail
{
    NSURLRequest *request = [[ABRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

- (NSInteger)callPUTWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ABCallback)success
                          fail:(ABCallback)fail
{
    NSURLRequest *request = [[ABRequestGenerator sharedInstance] generatePUTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

- (NSInteger)callDELETEWithParams:(NSDictionary *)params
                serviceIdentifier:(NSString *)servieIdentifier
                       methodName:(NSString *)methodName
                          success:(ABCallback)success
                             fail:(ABCallback)fail
{
    NSURLRequest *request = [[ABRequestGenerator sharedInstance] generateDELETERequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(ABCallback)success
                            fail:(ABCallback)fail
{
    NSLog(@"\n==================================\n\nRequest Start: \n\n %@\n\n==================================", request.URL);
    
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          NSNumber *requestId = @([dataTask taskIdentifier]);
                                          [self.dispatchTable removeObjectForKey:requestId];
                                          
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          NSData *responseData = responseObject;
                                          NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                                          
                                          if (error) {
                                              [ABLogger logDebugInfoWithResponse:httpResponse
                                                                   resposeString:responseString
                                                                         request:request
                                                                           error:error];
                                              ABURLResponse *ABResponse = [[ABURLResponse alloc] initWithResponseString:responseString requestId:requestId request:request responseData:responseData error:error];
                                              fail?fail(ABResponse):nil;
                                          } else {
                                              // 检查http response是否成立。
                                              [ABLogger logDebugInfoWithResponse:httpResponse
                                                                   resposeString:responseString
                                                                         request:request
                                                                           error:NULL];
                                              ABURLResponse *ABResponse = [[ABURLResponse alloc] initWithResponseString:responseString requestId:requestId request:request responseData:responseData status:ABURLResponseStatusSuccess];
                                              success?success(ABResponse):nil;
                                          }
                                      }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatchTable[requestId] = dataTask;
    
    [dataTask resume];
    
    return requestId;
}

@end
