//
//  ABURLResponse.m
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABURLResponse.h"
#import "NSURLRequest+ABNetworkingAddtions.h"

@interface ABURLResponse ()

@property (nonatomic, assign, readwrite) ABURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *responseString;
@property (nonatomic, strong, readwrite) id content;
@property (nonatomic, strong, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, strong, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end

@implementation ABURLResponse

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(ABURLResponseStatus)status
{
    self = [super init];
    if (self) {
        self.responseString = responseString;
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.responseString = responseString;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private methods
- (ABURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        ABURLResponseStatus result = ABURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = ABURLResponseStatusErrorTimeout;
        }
        return result;
    } else {
        return ABURLResponseStatusSuccess;
    }
}

@end
