//
//  ABRequestGenerator.m
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABRequestGenerator.h"
#import "AFNetworking.h"
#import "ABNetworkingConfig.h"
#import "NSURLRequest+ABNetworkingAddtions.h"
#import "ABCommonParamsGenerator.h"
#import "ABService.h"
#import "ABServiceFactory.h"

@interface ABRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation ABRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ABRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ABRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName
{
    ABService *service = [[ABServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = @"";
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }

    NSMutableDictionary *params = [requestParams mutableCopy];
    [params addEntriesFromDictionary:[ABCommonParamsGenerator commonParamsDictionary]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:params error:nil];
    request.requestParams = requestParams;
    
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName
{
    ABService *service = [[ABServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = @"";
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    NSMutableDictionary *params = [requestParams mutableCopy];
    [params addEntriesFromDictionary:[ABCommonParamsGenerator commonParamsDictionary]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:params error:nil];
    request.requestParams = requestParams;
    
    return request;
}

- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName

{
    ABService *service = [[ABServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = @"";
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    NSMutableDictionary *params = [requestParams mutableCopy];
    [params addEntriesFromDictionary:[ABCommonParamsGenerator commonParamsDictionary]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:params error:nil];
    request.requestParams = requestParams;
    
    return request;
}

- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                  methodName:(NSString *)methodName
{
    ABService *service = [[ABServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = @"";
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    NSMutableDictionary *params = [requestParams mutableCopy];
    [params addEntriesFromDictionary:[ABCommonParamsGenerator commonParamsDictionary]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:params error:nil];
    request.requestParams = requestParams;
    
    return request;
}

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kABNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

@end
